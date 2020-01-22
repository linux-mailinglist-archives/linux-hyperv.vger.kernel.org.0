Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3BE145E3D
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Jan 2020 22:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgAVVnA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Jan 2020 16:43:00 -0500
Received: from mail-eopbgr770103.outbound.protection.outlook.com ([40.107.77.103]:54851
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbgAVVm7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Jan 2020 16:42:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEZAVR6YBi6it29UPxf3DgaoeHTtJCWnIJXYAX/XUf6ILNgsoWtCTBwyo8qaGQx5D1ZThWhHEPowbEVLBwkaFJmo/6R0p7HwhAxt32S17eR0dHOEtDFQXb0mLZivglyAtqzzQk2kCkUnvu8qgF6qVVuNJKuZDaWG3bbYF2ynYZZlc/k79tmcXv3sI3aGHvq8DQ7OrJ7gCz+22OX4SHms4v+YrBOqAWZQa+fZMfqUt+hIdEqS54ewdNiJ4vu2wLaD9NS5yJDGzjESqsZNKVmKZWu7N1DN9bV6z0exTlLJoze5MCSdcVHLb1prKaz0qEeEMh6GDLaaL3ijv/f/zZOElQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrYtgktRdHdNOVrZyiOhbUoevCrh0M6VO+W5l9z1uAU=;
 b=GFIBIEX6AewpgVknYmcrSDB98EmhZq0XCDQ9oZ7csIhtg2ekHUaQG0/hOnmg+EV0sJjwe0R2ZBBOvpJd7fdS4AjY5laWPdII2VeMB8X3dq1pM/LMkt0KUx8g+inzwX1t4+OnCfpxiEF0i9xSKm/29KS4P4Wec4hON+zN/XaBNfcz8OSBRZ+V+w4opRk7Ofp7+PE58GilyjxYo2zrRYJLMtDpemETeNYfwJ/P1MkKOvvNScqKEWj5k46Ep4TJcryssQkcVdwhf+e0ISaxpMhz7gcOvGD/z+F1Smwqm8HQGXKZi2LCvZ8/6soAdr6kyw9EZ5vCAjKNMq8ixBL0KCJeog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrYtgktRdHdNOVrZyiOhbUoevCrh0M6VO+W5l9z1uAU=;
 b=P1pj66ATwG1u86IynGhF9AWTau4ypDUNUibUEn7xjEMFWKHxuPTxOIqaof2SM6nYpL3u47ufRjSSvCiftyHcSUeuVXJjsvICEs/5CY+ioqXQR9MYoe3lORJ09xiWA4gVttbmoCX9oRk80M543C1S2gbBzgbTHa+mjhh0L4Tf2DA=
Received: from SN6PR2101MB1023.namprd21.prod.outlook.com (52.132.117.31) by
 SN6PR2101MB1344.namprd21.prod.outlook.com (20.178.200.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.9; Wed, 22 Jan 2020 21:42:53 +0000
Received: from SN6PR2101MB1023.namprd21.prod.outlook.com
 ([fe80::68fb:50be:3f33:2edd]) by SN6PR2101MB1023.namprd21.prod.outlook.com
 ([fe80::68fb:50be:3f33:2edd%4]) with mapi id 15.20.2686.006; Wed, 22 Jan 2020
 21:42:53 +0000
From:   Long Li <longli@microsoft.com>
To:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Patch v4 1/2] PCI: hv: Decouple the func definition in
 hv_dr_state from VSP message
Thread-Topic: [Patch v4 1/2] PCI: hv: Decouple the func definition in
 hv_dr_state from VSP message
Thread-Index: AQHVyk09ZpI6noor9kG6MV8g7Smkvqf3ROSQ
Date:   Wed, 22 Jan 2020 21:42:52 +0000
Message-ID: <SN6PR2101MB10234B91D7748441CA18A361CE0C0@SN6PR2101MB1023.namprd21.prod.outlook.com>
References: <1578946101-74036-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1578946101-74036-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=de622098-dfc4-499e-bbb8-0000d6a42635;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-22T21:41:48Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:0:edee:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3bddfcb3-3d13-4bb7-350e-08d79f8408ed
x-ms-traffictypediagnostic: SN6PR2101MB1344:|SN6PR2101MB1344:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB13440E0B3EEA9A162049D709CE0C0@SN6PR2101MB1344.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(189003)(199004)(8676002)(52536014)(186003)(2906002)(71200400001)(5660300002)(33656002)(8936002)(86362001)(9686003)(66446008)(7696005)(478600001)(8990500004)(15650500001)(10290500003)(110136005)(316002)(81166006)(81156014)(6506007)(66946007)(55016002)(76116006)(64756008)(66556008)(66476007)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1344;H:SN6PR2101MB1023.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mX8JDklpBMuVjA1Hm6u3X1uqqdibA5GfOiocxjNcGlAo+ATrw9JjHVzAhVu6PuB9Eyr8MzKjxLm5vHz4P7Iah7Dz51AneAPyfcDSwP36ZnMCGrnIbXwxKQgHuuWfoQoXEE50TvIOgktUXEdu61k2GlJWu05RcHaVwx2tJZa/X/HEOQds5NVjbl/jhykn261yi20mKA7+eA5svSFgkN6d2mnLbpdASQJpgYydP4LDCBaJGUJRsThqDMIKDkTJ7zEMr8c7fDwP0WZ5i5qVTNCRhqDZma5VUCiKmjWvvRANc73tgkaNcbh4HZSnop+Fqg2yTH3H4cm40Y8o+0b7IcbYF1elMGjiM3rm3XK7KjQ1zV6iDdYIFIJaf201D7m78iFYasyn89rp1cJvNVE2cdszNCJ7EIb2f5PET2KPDDalsj0M26scrxfInyg/HbkSExt/BpcHlzU4tp6minS3DVnvsU3buJk99QLyeZnDtj8EOmN79OdsTwG8rbOwBeJOXTRS
x-ms-exchange-antispam-messagedata: KFSpBbVSfC3KdqyI3OVp12KpTjFGffgCgSUUYKPUWeKWU6Zxsl3aryj2FqVCj9FI8dqAhkxueQ2g9XrHEcJJF052gM0UOPEiWNhLhHhQUNiNkxK/TM/IuRWfd4epDYumXheGLsELVLel2jCGehqH95Xx9kfbycVSqJb3/8nF7PkZuD8wA7A5sf5vhXKSnr6u0Yw5GDjhV8//i68AMt5QtA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bddfcb3-3d13-4bb7-350e-08d79f8408ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 21:42:52.8578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NFouEtazWnSATOVx7HyMxVjxE8dqduKktHIaEbdrBJw6jov2b2QuqYLLiyFitgs52rakiFd/kYsGL/wnMWWAfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1344
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Lorenzo,

Can you take a look at this patch?

Thanks

Long

>Subject: [Patch v4 1/2] PCI: hv: Decouple the func definition in hv_dr_sta=
te from
>VSP message
>
>From: Long Li <longli@microsoft.com>
>
>hv_dr_state is used to find present PCI devices on the bus. The structure =
reuses
>struct pci_function_description from VSP message to describe a device.
>
>To prepare support for pci_function_description v2, decouple this dependen=
ce in
>hv_dr_state so it can work with both v1 and v2 VSP messages.
>
>There is no functionality change.
>
>Signed-off-by: Long Li <longli@microsoft.com>
>Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>---
>Changes
>v2: Changed some spaces to tabs, changed failure code to -ENOMEM
>v3: Revised comment for function hv_pci_devices_present(), reformatted pat=
ch
>title
>v4: Fixed spelling
>
> drivers/pci/controller/pci-hyperv.c | 101 +++++++++++++++++++---------
> 1 file changed, 70 insertions(+), 31 deletions(-)
>
>diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/=
pci-
>hyperv.c
>index f1f300218fab..3b3e1967cf08 100644
>--- a/drivers/pci/controller/pci-hyperv.c
>+++ b/drivers/pci/controller/pci-hyperv.c
>@@ -507,10 +507,24 @@ struct hv_dr_work {
> 	struct hv_pcibus_device *bus;
> };
>
>+struct hv_pcidev_description {
>+	u16	v_id;	/* vendor ID */
>+	u16	d_id;	/* device ID */
>+	u8	rev;
>+	u8	prog_intf;
>+	u8	subclass;
>+	u8	base_class;
>+	u32	subsystem_id;
>+	union	win_slot_encoding win_slot;
>+	u32	ser;	/* serial number */
>+	u32	flags;
>+	u16	virtual_numa_node;
>+};
>+
> struct hv_dr_state {
> 	struct list_head list_entry;
> 	u32 device_count;
>-	struct pci_function_description func[0];
>+	struct hv_pcidev_description func[0];
> };
>
> enum hv_pcichild_state {
>@@ -527,7 +541,7 @@ struct hv_pci_dev {
> 	refcount_t refs;
> 	enum hv_pcichild_state state;
> 	struct pci_slot *pci_slot;
>-	struct pci_function_description desc;
>+	struct hv_pcidev_description desc;
> 	bool reported_missing;
> 	struct hv_pcibus_device *hbus;
> 	struct work_struct wrk;
>@@ -1862,7 +1876,7 @@ static void q_resource_requirements(void *context,
>struct pci_response *resp,
>  * Return: Pointer to the new tracking struct
>  */
> static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hb=
us,
>-		struct pci_function_description *desc)
>+		struct hv_pcidev_description *desc)
> {
> 	struct hv_pci_dev *hpdev;
> 	struct pci_child_message *res_req;
>@@ -1973,7 +1987,7 @@ static void pci_devices_present_work(struct
>work_struct *work)  {
> 	u32 child_no;
> 	bool found;
>-	struct pci_function_description *new_desc;
>+	struct hv_pcidev_description *new_desc;
> 	struct hv_pci_dev *hpdev;
> 	struct hv_pcibus_device *hbus;
> 	struct list_head removed;
>@@ -2090,43 +2104,26 @@ static void pci_devices_present_work(struct
>work_struct *work)
> 	put_hvpcibus(hbus);
> 	kfree(dr);
> }
>-
> /**
>- * hv_pci_devices_present() - Handles list of new children
>+ * hv_pci_start_relations_work() - Queue work to start device discovery
>  * @hbus:	Root PCI bus, as understood by this driver
>- * @relations:	Packet from host listing children
>+ * @dr:		The list of children returned from host
>  *
>- * This function is invoked whenever a new list of devices for
>- * this bus appears.
>+ * Return:  0 on success, -errno on failure
>  */
>-static void hv_pci_devices_present(struct hv_pcibus_device *hbus,
>-				   struct pci_bus_relations *relations)
>+static int hv_pci_start_relations_work(struct hv_pcibus_device *hbus,
>+				       struct hv_dr_state *dr)
> {
>-	struct hv_dr_state *dr;
> 	struct hv_dr_work *dr_wrk;
>-	unsigned long flags;
> 	bool pending_dr;
>+	unsigned long flags;
>
> 	dr_wrk =3D kzalloc(sizeof(*dr_wrk), GFP_NOWAIT);
> 	if (!dr_wrk)
>-		return;
>-
>-	dr =3D kzalloc(offsetof(struct hv_dr_state, func) +
>-		     (sizeof(struct pci_function_description) *
>-		      (relations->device_count)), GFP_NOWAIT);
>-	if (!dr)  {
>-		kfree(dr_wrk);
>-		return;
>-	}
>+		return -ENOMEM;
>
> 	INIT_WORK(&dr_wrk->wrk, pci_devices_present_work);
> 	dr_wrk->bus =3D hbus;
>-	dr->device_count =3D relations->device_count;
>-	if (dr->device_count !=3D 0) {
>-		memcpy(dr->func, relations->func,
>-		       sizeof(struct pci_function_description) *
>-		       dr->device_count);
>-	}
>
> 	spin_lock_irqsave(&hbus->device_list_lock, flags);
> 	/*
>@@ -2144,6 +2141,47 @@ static void hv_pci_devices_present(struct
>hv_pcibus_device *hbus,
> 		get_hvpcibus(hbus);
> 		queue_work(hbus->wq, &dr_wrk->wrk);
> 	}
>+
>+	return 0;
>+}
>+
>+/**
>+ * hv_pci_devices_present() - Handle list of new children
>+ * @hbus:	Root PCI bus, as understood by this driver
>+ * @relations:	Packet from host listing children
>+ *
>+ * Process a new list of devices on the bus. The list of devices is
>+ * discovered by VSP and sent to us via VSP message PCI_BUS_RELATIONS,
>+ * whenever a new list of devices for this bus appears.
>+ */
>+static void hv_pci_devices_present(struct hv_pcibus_device *hbus,
>+				   struct pci_bus_relations *relations) {
>+	struct hv_dr_state *dr;
>+	int i;
>+
>+	dr =3D kzalloc(offsetof(struct hv_dr_state, func) +
>+		     (sizeof(struct hv_pcidev_description) *
>+		      (relations->device_count)), GFP_NOWAIT);
>+
>+	if (!dr)
>+		return;
>+
>+	dr->device_count =3D relations->device_count;
>+	for (i =3D 0; i < dr->device_count; i++) {
>+		dr->func[i].v_id =3D relations->func[i].v_id;
>+		dr->func[i].d_id =3D relations->func[i].d_id;
>+		dr->func[i].rev =3D relations->func[i].rev;
>+		dr->func[i].prog_intf =3D relations->func[i].prog_intf;
>+		dr->func[i].subclass =3D relations->func[i].subclass;
>+		dr->func[i].base_class =3D relations->func[i].base_class;
>+		dr->func[i].subsystem_id =3D relations->func[i].subsystem_id;
>+		dr->func[i].win_slot =3D relations->func[i].win_slot;
>+		dr->func[i].ser =3D relations->func[i].ser;
>+	}
>+
>+	if (hv_pci_start_relations_work(hbus, dr))
>+		kfree(dr);
> }
>
> /**
>@@ -3018,7 +3056,7 @@ static void hv_pci_bus_exit(struct hv_device *hdev)
> 		struct pci_packet teardown_packet;
> 		u8 buffer[sizeof(struct pci_message)];
> 	} pkt;
>-	struct pci_bus_relations relations;
>+	struct hv_dr_state *dr;
> 	struct hv_pci_compl comp_pkt;
> 	int ret;
>
>@@ -3030,8 +3068,9 @@ static void hv_pci_bus_exit(struct hv_device *hdev)
> 		return;
>
> 	/* Delete any children which might still exist. */
>-	memset(&relations, 0, sizeof(relations));
>-	hv_pci_devices_present(hbus, &relations);
>+	dr =3D kzalloc(sizeof(*dr), GFP_KERNEL);
>+	if (dr && hv_pci_start_relations_work(hbus, dr))
>+		kfree(dr);
>
> 	ret =3D hv_send_resources_released(hdev);
> 	if (ret)
>--
>2.17.1

