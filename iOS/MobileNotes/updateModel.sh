#! /bin/sh

modelName="MobileNotes"
modelPath=${PROJECT_DIR}/${PROJECT_NAME}/${modelName}

outDir=${PROJECT_DIR}/${PROJECT_NAME}/mo
outMachineDir=$outDir/_

if [ ! -d ${modelPath}.xcdatamodeld ]; then
	echo "Could not find ${modelPath}.xcdatamodeld"
	exit 1
fi

modelVersion="`cat ${modelPath}.xcdatamodeld/.xccurrentversion | grep xcdatamodel | sed 's/[[:blank:]]*<[^>]*>//g'`"

if [ ! -d "${modelPath}.xcdatamodeld/${modelVersion}" ]; then
	echo "Could not find version ${modelPath}.xcdatamodeld/${modelVersion}"
	exit 1
fi

if [ ! -d $outDir ]; then
	mkdir $outDir
fi

if [ ! -d $outMachineDir ]; then
	mkdir $outMachineDir
fi

mogenerator \
	-m "${modelPath}.xcdatamodeld/${modelVersion}" \
	--template-var arc=true \
	--base-class GVCManagedObject \
	--machine-dir $outMachineDir \
	--human-dir $outDir

