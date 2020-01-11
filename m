Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA79B137C59
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jan 2020 09:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgAKI1a (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 11 Jan 2020 03:27:30 -0500
Received: from mail-dm6nam10on2138.outbound.protection.outlook.com ([40.107.93.138]:51658
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728593AbgAKI1a (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 11 Jan 2020 03:27:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMQ6akqCne0chjV6PhyaqKPx7hz7wTp5rgesbwuYKAluMFz8Ptv85ukWKe6BF55q/KsZImCkJa9g9s7uPY7mQ9yIGuC/qMnEKrfoTswP3IDn9iu1IAjG1+j4ENphpSBQ7Fszpwf1xvDlX8B5VHmX7MlBuhKg5OnYWFrk8dOhL6QIvXb5jki2H5ZDAIcFU2mgJBP04/jrrHxQgICxlTHM5DDxRPJa3nU5vKlMdBdJPSvR7ddVgRPMouCMMr8RFVBh4xp26l+2MYSkXdgfXKyvP2PNooH8mQa2V0PJX9cYv6efJsSqJdG13QxZLR7sL4ctu4q/Q3AeBMYPOWUZMTDunA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VK2J+Hy1n+X/3sXCRsEIgoON8NA08v+BBwKh6+kmCnM=;
 b=hth8jbampoEwlSu4ArglSG/iRgb65qsop8ZRHOM/CBfYgxrigz1/SQFa+6Xy6jqLv4R5LG1sliMo5lB9dBDrmmZIDwHQUZiXPGX0ndGbsDsNPdGAgu19VvycI8lmWVCHMbSuptBv/AUQEZHyq9OXnSmKDxq1vEnRcSyDm+RN1WOd4m1EdB+1tNxw8repwgw5h/iwUlrTx65y/DXn9GaIj4cBP+EhWxgFDgnKbp8rKWZaxjRTxKCcVRO8ZS5htq9jhQLP1yywsR7YyMuHxrz5jr90hUHhQALo+XXDwJ4+D9VZQN3tJgbqkNZW8BiesFlb0qKmf8azK++TgvdLn4dCnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VK2J+Hy1n+X/3sXCRsEIgoON8NA08v+BBwKh6+kmCnM=;
 b=W1Fy7PxP4rCvEv4XafdReFxCdnGuE0gNiAqdsdfrzDJf9UNXs1X370ISTyYp5b+p+8jzp5GquTI1WQkQq43JXgMhzkCj1voaMw/UtoMxbnO5TO5R73ZTf1BCByU4nuWemk7cX+crHBNsF2a6aDx+qjL2gPasF5GGrjzG2CUGTK4=
Received: from BL0PR2101MB1123.namprd21.prod.outlook.com (52.132.20.151) by
 BL0PR2101MB1316.namprd21.prod.outlook.com (20.177.244.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.1; Sat, 11 Jan 2020 08:27:25 +0000
Received: from BL0PR2101MB1123.namprd21.prod.outlook.com
 ([fe80::d1de:7b03:3f66:19fb]) by BL0PR2101MB1123.namprd21.prod.outlook.com
 ([fe80::d1de:7b03:3f66:19fb%6]) with mapi id 15.20.2644.013; Sat, 11 Jan 2020
 08:27:25 +0000
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
Subject: RE: [Patch v3 1/2] PCI: hv: Decouple the func definition in
 hv_dr_state from VSP message
Thread-Topic: [Patch v3 1/2] PCI: hv: Decouple the func definition in
 hv_dr_state from VSP message
Thread-Index: AQHVvCRkF/InBl2gY02lH0V30pa41qflORQg
Date:   Sat, 11 Jan 2020 08:27:25 +0000
Message-ID: <BL0PR2101MB1123229A668A200C34A2888ECE3B0@BL0PR2101MB1123.namprd21.prod.outlook.com>
References: <1577389241-108450-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1577389241-108450-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=805e8485-ab9c-46f6-a5d3-00008420557a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-11T08:25:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:0:edee:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f0374db2-3fde-41ac-942d-08d79670167b
x-ms-traffictypediagnostic: BL0PR2101MB1316:|BL0PR2101MB1316:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR2101MB1316E8C15522EB1611760876CE3B0@BL0PR2101MB1316.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0279B3DD0D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(40224003)(199004)(189003)(478600001)(8936002)(186003)(52536014)(76116006)(66946007)(9686003)(55016002)(71200400001)(15650500001)(86362001)(33656002)(81166006)(81156014)(8676002)(7696005)(10290500003)(66476007)(316002)(8990500004)(2906002)(5660300002)(110136005)(6506007)(66556008)(66446008)(64756008)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1316;H:BL0PR2101MB1123.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4x+fzVZDyGn3e+u/hLoSqicpYXYaIRhylSHIxpXe5zhReK31V4+lMg5Z8vleWc0FvIu4XP34QgVaI6feCoXj3UMC8UwYepagqEy7VwkKmEz/XnPhaxlP+r8703J8hkdQyxmBn9FbJxXDN4i7qg3+IEs6ffujkNxWbp2yxbSJKteS6q1DB+b8aNBbDKyt90NMXIHVTVG06vb9Kd06/OG7N4fXt3VWZt4c5ooPAhXZU4BkjMM7Ri+ZVeajOl4Nru3Wj6QULuS2F5K0goPtkpBfUjFNe/kaJxrZ8RgHjvWsn1eLwDTlvsrV+GoKHuB+av072STc0HoH3DpaCzz1D8WhGMOvxTeBHH3CinCdm+cm1WY6x2jUMSS9spQ8mm2REX5hhfXFE/Y6cKASIK/2Ex5iR7LG7NiIFyfUiIObers9T8CdBj8BvPCyBztZZRUjKLY/30qgbSrZN8TLKAMauwlzYHEFaSoUzkmmOKKJPJbhLgIWMuVrvLMTkqJtlij/kku4xRdHGD8GlLUfKrabkH6CUg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0374db2-3fde-41ac-942d-08d79670167b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2020 08:27:25.1117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EDaMfvY1RzWCW1Xvz4eX5WdXamI5XQ9Nx9MftvprdbsccLZwAOJJs22PcBTJv0EXBKKbORdB6ntztD8fHR/NIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1316
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Bjorn,

I have addressed all the prior comments in this v3 patch. Please take a loo=
k.

Thanks

Long

>Subject: [Patch v3 1/2] PCI: hv: Decouple the func definition in hv_dr_sta=
te from
>VSP message
>
>From: Long Li <longli@microsoft.com>
>
>hv_dr_state is used to find present PCI devices on the bus. The structure =
reuses
>struct pci_function_description from VSP message to describe a device.
>
>To prepare support for pci_function_description v2, we need to decouple th=
is
>dependence in hv_dr_state so it can work with both v1 and v2 VSP messages.
>
>There is no functionality change.
>
>Signed-off-by: Long Li <longli@microsoft.com>
>---
>Changes
>v2: changed some spaces to tabs, changed failure code to -ENOMEM
>v3: revised comment for function hv_pci_devices_present(), reformatted pat=
ch
>title
>
> drivers/pci/controller/pci-hyperv.c | 101 +++++++++++++++++++---------
> 1 file changed, 70 insertions(+), 31 deletions(-)
>
>diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/=
pci-
>hyperv.c
>index f1f300218fab..4452c6bae6cf 100644
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
>+ * hv_pci_devices_present() - Handles list of new children
>+ * @hbus:	Root PCI bus, as understood by this driver
>+ * @relations:	Packet from host listing children
>+ *
>+ * This function processes a new list of devices on the bus. The list
>+of
>+ * devices is discoverd by VSP and sent to us via VSP message
>+ * PCI_BUS_RELATIONS, whenever a new list of devices for this bus appears=
.
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

