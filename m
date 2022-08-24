Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8DC59FFF3
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Aug 2022 19:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239783AbiHXRAC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 24 Aug 2022 13:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239764AbiHXQ75 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 24 Aug 2022 12:59:57 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76041B865;
        Wed, 24 Aug 2022 09:59:53 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id e7610e5002f015e7; Wed, 24 Aug 2022 18:59:51 +0200
Received: from kreacher.localnet (unknown [213.134.169.54])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 6CCAE66D192;
        Wed, 24 Aug 2022 18:59:49 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Mark Brown <broonie@kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-hyperv@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH v2 5/5] ACPI: Drop parent field from struct acpi_device
Date:   Wed, 24 Aug 2022 18:59:48 +0200
Message-ID: <5857822.lOV4Wx5bFT@kreacher>
In-Reply-To: <2196460.iZASKD2KPV@kreacher>
References: <12036348.O9o76ZdvQC@kreacher> <2196460.iZASKD2KPV@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.169.54
X-CLIENT-HOSTNAME: 213.134.169.54
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejuddguddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepvddufedrudefgedrudeiledrheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeiledrheegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopedvgedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgv
 rhhnvghlrdhorhhgpdhrtghpthhtohepkhihshesmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopehhrghihigrnhhgiiesmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopehsthhhvghmmhhinhesmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopeifvghirdhlihhusehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvggtuhhisehmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvggrshdrnhhovghvvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhitghhrggvlhdrjhgrmhgvthesihhnthgvlhdrtghomhdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepjggvhhgviihkvghlufhhueesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhhhihpvghrvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidquhhssgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhmshhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhls
 ehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopegrghhrohhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghjohhrnhdrrghnuggvrhhsshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtohepkhhonhhrrggurdguhigstghiohesshhomhgrihhnlhhinhgvrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=24 Fuz1=24 Fuz2=24
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The parent field in struct acpi_device is, in fact, redundant,
because the dev.parent field in it effectively points to the same
object and it is used by the driver core.

Accordingly, the parent field can be dropped from struct acpi_device
and for this purpose define acpi_dev_parent() to retrieve a parent
struct acpi_device pointer from the dev.parent field in struct
acpi_device.  Next, update all of the users of the parent field
in struct acpi_device to use acpi_dev_parent() instead of it and
drop it.

While at it, drop the ACPI_IS_ROOT_DEVICE() macro that is only used
in one place in a confusing way.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Wei Liu <wei.liu@kernel.org>
Reviewed-by: Punit Agrawal <punit.agrawal@bytedance.com>
---

v1 -> v2:
   * Cover 3 more users of the parent field in struct acpi_device.
   * Add tags collected so far.

---
 drivers/acpi/acpi_amba.c     |    5 +++--
 drivers/acpi/acpi_platform.c |    6 +++---
 drivers/acpi/acpi_video.c    |    2 +-
 drivers/acpi/device_pm.c     |   19 ++++++++++---------
 drivers/acpi/property.c      |    6 ++++--
 drivers/acpi/sbs.c           |    2 +-
 drivers/acpi/sbshc.c         |    2 +-
 drivers/acpi/scan.c          |   17 ++++++-----------
 drivers/hv/vmbus_drv.c       |    3 ++-
 drivers/perf/arm_dsu_pmu.c   |    4 ++--
 drivers/perf/qcom_l3_pmu.c   |    3 ++-
 drivers/spi/spi.c            |    2 +-
 drivers/thunderbolt/acpi.c   |    2 +-
 include/acpi/acpi_bus.h      |   10 +++++++++-
 14 files changed, 46 insertions(+), 37 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -29,8 +29,6 @@ extern struct acpi_device *acpi_root;
 #define ACPI_BUS_HID			"LNXSYBUS"
 #define ACPI_BUS_DEVICE_NAME		"System Bus"
 
-#define ACPI_IS_ROOT_DEVICE(device)    (!(device)->parent)
-
 #define INVALID_ACPI_HANDLE	((acpi_handle)empty_zero_page)
 
 static const char *dummy_hid = "device";
@@ -1110,7 +1108,7 @@ static void acpi_device_get_busid(struct
 	 * The device's Bus ID is simply the object name.
 	 * TBD: Shouldn't this value be unique (within the ACPI namespace)?
 	 */
-	if (ACPI_IS_ROOT_DEVICE(device)) {
+	if (!acpi_dev_parent(device)) {
 		strcpy(device->pnp.bus_id, "ACPI");
 		return;
 	}
@@ -1646,7 +1644,7 @@ static void acpi_init_coherency(struct a
 {
 	unsigned long long cca = 0;
 	acpi_status status;
-	struct acpi_device *parent = adev->parent;
+	struct acpi_device *parent = acpi_dev_parent(adev);
 
 	if (parent && parent->flags.cca_seen) {
 		/*
@@ -1690,7 +1688,7 @@ static int acpi_check_serial_bus_slave(s
 
 static bool acpi_is_indirect_io_slave(struct acpi_device *device)
 {
-	struct acpi_device *parent = device->parent;
+	struct acpi_device *parent = acpi_dev_parent(device);
 	static const struct acpi_device_id indirect_io_hosts[] = {
 		{"HISI0191", 0},
 		{}
@@ -1767,10 +1765,7 @@ void acpi_init_device_object(struct acpi
 	INIT_LIST_HEAD(&device->pnp.ids);
 	device->device_type = type;
 	device->handle = handle;
-	if (parent) {
-		device->parent = parent;
-		device->dev.parent = &parent->dev;
-	}
+	device->dev.parent = parent ? &parent->dev : NULL;
 	device->dev.release = release;
 	device->dev.bus = &acpi_bus_type;
 	fwnode_init(&device->fwnode, &acpi_device_fwnode_ops);
@@ -1867,8 +1862,8 @@ static int acpi_add_single_object(struct
 	acpi_device_add_finalize(device);
 
 	acpi_handle_debug(handle, "Added as %s, parent %s\n",
-			  dev_name(&device->dev), device->parent ?
-				dev_name(&device->parent->dev) : "(null)");
+			  dev_name(&device->dev), device->dev.parent ?
+				dev_name(device->dev.parent) : "(null)");
 
 	*child = device;
 	return 0;
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -365,7 +365,6 @@ struct acpi_device {
 	int device_type;
 	acpi_handle handle;		/* no handle for fixed hardware */
 	struct fwnode_handle fwnode;
-	struct acpi_device *parent;
 	struct list_head wakeup_list;
 	struct list_head del_list;
 	struct acpi_device_status status;
@@ -458,6 +457,14 @@ static inline void *acpi_driver_data(str
 #define to_acpi_device(d)	container_of(d, struct acpi_device, dev)
 #define to_acpi_driver(d)	container_of(d, struct acpi_driver, drv)
 
+static inline struct acpi_device *acpi_dev_parent(struct acpi_device *adev)
+{
+	if (adev->dev.parent)
+		return to_acpi_device(adev->dev.parent);
+
+	return NULL;
+}
+
 static inline void acpi_set_device_status(struct acpi_device *adev, u32 sta)
 {
 	*((u32 *)&adev->status) = sta;
@@ -478,6 +485,7 @@ void acpi_initialize_hp_context(struct a
 /* acpi_device.dev.bus == &acpi_bus_type */
 extern struct bus_type acpi_bus_type;
 
+struct acpi_device *acpi_dev_parent(struct acpi_device *adev);
 int acpi_bus_for_each_dev(int (*fn)(struct device *, void *), void *data);
 int acpi_dev_for_each_child(struct acpi_device *adev,
 			    int (*fn)(struct acpi_device *, void *), void *data);
Index: linux-pm/drivers/acpi/property.c
===================================================================
--- linux-pm.orig/drivers/acpi/property.c
+++ linux-pm/drivers/acpi/property.c
@@ -304,8 +304,10 @@ static void acpi_init_of_compatible(stru
 		ret = acpi_dev_get_property(adev, "compatible",
 					    ACPI_TYPE_STRING, &of_compatible);
 		if (ret) {
-			if (adev->parent
-			    && adev->parent->flags.of_compatible_ok)
+			struct acpi_device *parent;
+
+			parent = acpi_dev_parent(adev);
+			if (parent && parent->flags.of_compatible_ok)
 				goto out;
 
 			return;
Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -74,6 +74,7 @@ static int acpi_dev_pm_explicit_get(stru
  */
 int acpi_device_get_power(struct acpi_device *device, int *state)
 {
+	struct acpi_device *parent = acpi_dev_parent(device);
 	int result = ACPI_STATE_UNKNOWN;
 	int error;
 
@@ -82,8 +83,7 @@ int acpi_device_get_power(struct acpi_de
 
 	if (!device->flags.power_manageable) {
 		/* TBD: Non-recursive algorithm for walking up hierarchy. */
-		*state = device->parent ?
-			device->parent->power.state : ACPI_STATE_D0;
+		*state = parent ? parent->power.state : ACPI_STATE_D0;
 		goto out;
 	}
 
@@ -122,10 +122,10 @@ int acpi_device_get_power(struct acpi_de
 	 * point, the fact that the device is in D0 implies that the parent has
 	 * to be in D0 too, except if ignore_parent is set.
 	 */
-	if (!device->power.flags.ignore_parent && device->parent
-	    && device->parent->power.state == ACPI_STATE_UNKNOWN
-	    && result == ACPI_STATE_D0)
-		device->parent->power.state = ACPI_STATE_D0;
+	if (!device->power.flags.ignore_parent && parent &&
+	    parent->power.state == ACPI_STATE_UNKNOWN &&
+	    result == ACPI_STATE_D0)
+		parent->power.state = ACPI_STATE_D0;
 
 	*state = result;
 
@@ -159,6 +159,7 @@ static int acpi_dev_pm_explicit_set(stru
  */
 int acpi_device_set_power(struct acpi_device *device, int state)
 {
+	struct acpi_device *parent = acpi_dev_parent(device);
 	int target_state = state;
 	int result = 0;
 
@@ -191,12 +192,12 @@ int acpi_device_set_power(struct acpi_de
 		return -ENODEV;
 	}
 
-	if (!device->power.flags.ignore_parent && device->parent &&
-	    state < device->parent->power.state) {
+	if (!device->power.flags.ignore_parent && parent &&
+	    state < parent->power.state) {
 		acpi_handle_debug(device->handle,
 				  "Cannot transition to %s for parent in %s\n",
 				  acpi_power_state_string(state),
-				  acpi_power_state_string(device->parent->power.state));
+				  acpi_power_state_string(parent->power.state));
 		return -ENODEV;
 	}
 
Index: linux-pm/drivers/acpi/acpi_platform.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_platform.c
+++ linux-pm/drivers/acpi/acpi_platform.c
@@ -78,7 +78,7 @@ static void acpi_platform_fill_resource(
 	 * If the device has parent we need to take its resources into
 	 * account as well because this device might consume part of those.
 	 */
-	parent = acpi_get_first_physical_node(adev->parent);
+	parent = acpi_get_first_physical_node(acpi_dev_parent(adev));
 	if (parent && dev_is_pci(parent))
 		dest->parent = pci_find_resource(to_pci_dev(parent), dest);
 }
@@ -97,6 +97,7 @@ static void acpi_platform_fill_resource(
 struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 						    const struct property_entry *properties)
 {
+	struct acpi_device *parent = acpi_dev_parent(adev);
 	struct platform_device *pdev = NULL;
 	struct platform_device_info pdevinfo;
 	struct resource_entry *rentry;
@@ -137,8 +138,7 @@ struct platform_device *acpi_create_plat
 	 * attached to it, that physical device should be the parent of the
 	 * platform device we are about to create.
 	 */
-	pdevinfo.parent = adev->parent ?
-		acpi_get_first_physical_node(adev->parent) : NULL;
+	pdevinfo.parent = parent ? acpi_get_first_physical_node(parent) : NULL;
 	pdevinfo.name = dev_name(&adev->dev);
 	pdevinfo.id = -1;
 	pdevinfo.res = resources;
Index: linux-pm/drivers/acpi/acpi_video.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_video.c
+++ linux-pm/drivers/acpi/acpi_video.c
@@ -2030,7 +2030,7 @@ static int acpi_video_bus_add(struct acp
 	acpi_status status;
 
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE,
-				device->parent->handle, 1,
+				acpi_dev_parent(device)->handle, 1,
 				acpi_video_bus_match, NULL,
 				device, NULL);
 	if (status == AE_ALREADY_EXISTS) {
Index: linux-pm/drivers/acpi/sbs.c
===================================================================
--- linux-pm.orig/drivers/acpi/sbs.c
+++ linux-pm/drivers/acpi/sbs.c
@@ -632,7 +632,7 @@ static int acpi_sbs_add(struct acpi_devi
 
 	mutex_init(&sbs->lock);
 
-	sbs->hc = acpi_driver_data(device->parent);
+	sbs->hc = acpi_driver_data(acpi_dev_parent(device));
 	sbs->device = device;
 	strcpy(acpi_device_name(device), ACPI_SBS_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_SBS_CLASS);
Index: linux-pm/drivers/acpi/sbshc.c
===================================================================
--- linux-pm.orig/drivers/acpi/sbshc.c
+++ linux-pm/drivers/acpi/sbshc.c
@@ -266,7 +266,7 @@ static int acpi_smbus_hc_add(struct acpi
 	mutex_init(&hc->lock);
 	init_waitqueue_head(&hc->wait);
 
-	hc->ec = acpi_driver_data(device->parent);
+	hc->ec = acpi_driver_data(acpi_dev_parent(device));
 	hc->offset = (val >> 8) & 0xff;
 	hc->query_bit = val & 0xff;
 	device->driver_data = hc;
Index: linux-pm/drivers/spi/spi.c
===================================================================
--- linux-pm.orig/drivers/spi/spi.c
+++ linux-pm/drivers/spi/spi.c
@@ -4375,7 +4375,7 @@ static int acpi_spi_notify(struct notifi
 
 	switch (value) {
 	case ACPI_RECONFIG_DEVICE_ADD:
-		ctlr = acpi_spi_find_controller_by_adev(adev->parent);
+		ctlr = acpi_spi_find_controller_by_adev(acpi_dev_parent(adev));
 		if (!ctlr)
 			break;
 
Index: linux-pm/drivers/thunderbolt/acpi.c
===================================================================
--- linux-pm.orig/drivers/thunderbolt/acpi.c
+++ linux-pm/drivers/thunderbolt/acpi.c
@@ -42,7 +42,7 @@ static acpi_status tb_acpi_add_link(acpi
 	 */
 	dev = acpi_get_first_physical_node(adev);
 	while (!dev) {
-		adev = adev->parent;
+		adev = acpi_dev_parent(adev);
 		if (!adev)
 			break;
 		dev = acpi_get_first_physical_node(adev);
Index: linux-pm/drivers/hv/vmbus_drv.c
===================================================================
--- linux-pm.orig/drivers/hv/vmbus_drv.c
+++ linux-pm/drivers/hv/vmbus_drv.c
@@ -2427,7 +2427,8 @@ static int vmbus_acpi_add(struct acpi_de
 	 * Some ancestor of the vmbus acpi device (Gen1 or Gen2
 	 * firmware) is the VMOD that has the mmio ranges. Get that.
 	 */
-	for (ancestor = device->parent; ancestor; ancestor = ancestor->parent) {
+	for (ancestor = acpi_dev_parent(device); ancestor;
+	     ancestor = acpi_dev_parent(ancestor)) {
 		result = acpi_walk_resources(ancestor->handle, METHOD_NAME__CRS,
 					     vmbus_walk_resources, NULL);
 
Index: linux-pm/drivers/acpi/acpi_amba.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_amba.c
+++ linux-pm/drivers/acpi/acpi_amba.c
@@ -48,6 +48,7 @@ static void amba_register_dummy_clk(void
 static int amba_handler_attach(struct acpi_device *adev,
 				const struct acpi_device_id *id)
 {
+	struct acpi_device *parent = acpi_dev_parent(adev);
 	struct amba_device *dev;
 	struct resource_entry *rentry;
 	struct list_head resource_list;
@@ -97,8 +98,8 @@ static int amba_handler_attach(struct ac
 	 * attached to it, that physical device should be the parent of
 	 * the amba device we are about to create.
 	 */
-	if (adev->parent)
-		dev->dev.parent = acpi_get_first_physical_node(adev->parent);
+	if (parent)
+		dev->dev.parent = acpi_get_first_physical_node(parent);
 
 	ACPI_COMPANION_SET(&dev->dev, adev);
 
Index: linux-pm/drivers/perf/arm_dsu_pmu.c
===================================================================
--- linux-pm.orig/drivers/perf/arm_dsu_pmu.c
+++ linux-pm/drivers/perf/arm_dsu_pmu.c
@@ -639,6 +639,7 @@ static int dsu_pmu_dt_get_cpus(struct de
 static int dsu_pmu_acpi_get_cpus(struct device *dev, cpumask_t *mask)
 {
 #ifdef CONFIG_ACPI
+	struct acpi_device *parent_adev = acpi_dev_parent(ACPI_COMPANION(dev));
 	int cpu;
 
 	/*
@@ -653,8 +654,7 @@ static int dsu_pmu_acpi_get_cpus(struct
 			continue;
 
 		acpi_dev = ACPI_COMPANION(cpu_dev);
-		if (acpi_dev &&
-			acpi_dev->parent == ACPI_COMPANION(dev)->parent)
+		if (acpi_dev && acpi_dev_parent(acpi_dev) == parent_adev)
 			cpumask_set_cpu(cpu, mask);
 	}
 #endif
Index: linux-pm/drivers/perf/qcom_l3_pmu.c
===================================================================
--- linux-pm.orig/drivers/perf/qcom_l3_pmu.c
+++ linux-pm/drivers/perf/qcom_l3_pmu.c
@@ -742,7 +742,8 @@ static int qcom_l3_cache_pmu_probe(struc
 
 	l3pmu = devm_kzalloc(&pdev->dev, sizeof(*l3pmu), GFP_KERNEL);
 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "l3cache_%s_%s",
-		      acpi_dev->parent->pnp.unique_id, acpi_dev->pnp.unique_id);
+		      acpi_dev_parent(acpi_dev)->pnp.unique_id,
+		      acpi_dev->pnp.unique_id);
 	if (!l3pmu || !name)
 		return -ENOMEM;
 



