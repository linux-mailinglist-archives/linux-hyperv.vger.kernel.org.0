Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70BAE154F82
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Feb 2020 00:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgBFXvQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Feb 2020 18:51:16 -0500
Received: from mail-dm6nam12on2125.outbound.protection.outlook.com ([40.107.243.125]:49249
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726502AbgBFXvQ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Feb 2020 18:51:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhAAiLXQwPZmj0UT2cZW3vhl9ReSmt2mb6dCcBWR+TJdLpKVIrA66EYzUzBk1ykFRTIU/APY+xswMW5dgkERpDNQuvRsuL3v/9IgAhvzEQ47Ivy90ubkvbZMXjZAI/hCKryQ8YR7Yu7yNOk5yTNO8c69ZjsHqXeExsAP3a91bVGzsHMRD/Qmx1PX8SjwcxO6KaFdpk5yKNnRepz1+CEjYRGXXppLnJ3Mi3v55lTS0CBpISWJg2KwfGQBXRIiMaAvzI9y+v2bN63W37MATrzeyH/G05nCa/AmoIVZXN62/9nox/CWhI1oEWp9c2zQtO4r8AGzT0NcAemQZCtvvHnmTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSc2LAi5Ve36RfDoc3BI3AWO5aCzFhdjWtALi+ulp2c=;
 b=hqGdbMQAo3LoPdPvnRec0T8FAn2lrXHz5LUzr9zvbAEuWx8HWc1fY/gA5XylKSWYd1SLbwN+8Tn7n6DDveiUH8qsfVwuzknJ+wR5qDtcHgBQ3PjAChzFkFHaLr0EbHSroexgoY8VzPq/Yg7gegZEjZB3iutSSYpN9tuiV+3rRMj6CekByrXE+QIWBBy7VI6Ev7075K4TQxCJOgJexKRwbdRtZfKl8BBChm+fsC3Use7Pfi3GwTxbpnYqyJs/OIa6erl+wdta3/0NG1sekNJUrA0eadb8Z4Qi7kGmKpTfue63jSFJZHtp7HBVye2Dvlrz7zFiBqVEYv0y+N0eteeaCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSc2LAi5Ve36RfDoc3BI3AWO5aCzFhdjWtALi+ulp2c=;
 b=jj0OX0wTF7dfxDGCc0BP6AFMQlrL0mG/dARupRABUaVnucef+CeXDMgErU86qPYyV8JRGfSq+Gk7QWTOKYC+nrydGgWUGgPkhZmJ+yU2DTExrFWUKC4DV5b5NYOoMaLRAydoBqSuTOUXhcQuJdHHtjbUoU0ad1FZf8FGTIBZITw=
Received: from BN8PR21MB1155.namprd21.prod.outlook.com (20.179.72.202) by
 BN8PR21MB1236.namprd21.prod.outlook.com (20.179.73.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.5; Thu, 6 Feb 2020 23:48:38 +0000
Received: from BN8PR21MB1155.namprd21.prod.outlook.com
 ([fe80::9123:f430:1749:be38]) by BN8PR21MB1155.namprd21.prod.outlook.com
 ([fe80::9123:f430:1749:be38%8]) with mapi id 15.20.2729.010; Thu, 6 Feb 2020
 23:48:37 +0000
From:   Long Li <longli@microsoft.com>
To:     Long Li <longli@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
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
Thread-Index: AQHVyk09ZpI6noor9kG6MV8g7Smkvqf3ROSQgBe2D2A=
Date:   Thu, 6 Feb 2020 23:48:37 +0000
Message-ID: <BN8PR21MB1155B34C378807E67576F961CE1D0@BN8PR21MB1155.namprd21.prod.outlook.com>
References: <1578946101-74036-1-git-send-email-longli@linuxonhyperv.com>
 <SN6PR2101MB10234B91D7748441CA18A361CE0C0@SN6PR2101MB1023.namprd21.prod.outlook.com>
In-Reply-To: <SN6PR2101MB10234B91D7748441CA18A361CE0C0@SN6PR2101MB1023.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=de622098-dfc4-499e-bbb8-0000d6a42635;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-22T21:41:48Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:3:edeb:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db3db4c4-54ba-470b-a761-08d7ab5f1640
x-ms-traffictypediagnostic: BN8PR21MB1236:|BN8PR21MB1236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR21MB123615DEC9DF8E1546C52D04CE1D0@BN8PR21MB1236.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(189003)(199004)(15650500001)(478600001)(186003)(66476007)(33656002)(8990500004)(66946007)(66446008)(76116006)(5660300002)(64756008)(66556008)(6506007)(86362001)(2906002)(7696005)(52536014)(55016002)(110136005)(9686003)(81166006)(81156014)(8676002)(71200400001)(316002)(8936002)(10290500003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1236;H:BN8PR21MB1155.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: irl8qw/T19icpzPqlLhRcjD+CL03rwSH98Siyu3V/pNy7V1P+yCYI6OrIgPVKegOryw/eCOcF9G3Or86TTmm44y4HEJjvkQ0vcgMy/sjXs2B2+Ou/WhVEBb7GxEmC6Sm4QXP9O5E4WNRH/zi+ZmmT9PY2fY3p+yduav6swgNcBhNeRb/1PSGS/p1mEmR+wh+gR+keUZAJ9R5nsKWYe3/WFRe/Gv0VdTQrTqOkKX5wkQv3fo22eg0A1s3Ld2cd+/Px2Qi4rU1ue0wwVNFFI6uc2V7NhVPwBh1BsvwCyZv7iMPWFJCSd21Q1nOHb4lnE/V6qkhRM/GXMieZKkFm0tpp/vM8vxUaUZNAg5kdy4dILGYfWkOERcucS37LymoF+At6GDqapqYe7CO/reqcXZTj8W/yzjgM+bAQ26xkOz9kZWs0bOhejg0Z5pCRJDsHT5jF18ZeSMxvwDnCGTFC+fRETxRJ1cyC/fQXXlSZRNViZpJFjqhwMBgc2q5bEiPhrPV
x-ms-exchange-antispam-messagedata: 6a7JHjvy5bErj75R24LfPLvN4NkYHoW1Nxlu5rXkJv0VM6nmlHzf+GAtignmtuSIy0e1Msc+4UvjVlUTAzy+WkEHJbw5Y5qkMEs6Y+xMZpofv38+81TESaUJmzmppjyG2OYnJIn9WxJ9gIRXayATJ/bBx0eh9gBW67jewixwNX4ewpsLoVV4Pin/e6BeV2iJKCUE/kOsrvCIhBg6Dn10lg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3db4c4-54ba-470b-a761-08d7ab5f1640
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 23:48:37.8214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pgAGcvNcghMw8NLEWpImlQpaz96UZYMt/n+byirRCV3GZBxRwLj2dos6HSW7XD7osvbbpk4D+cgEDqENoJ/vBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1236
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi guys,

Ping again...

Please take a look at these two patches.

Thanks

Long

>Subject: RE: [Patch v4 1/2] PCI: hv: Decouple the func definition in hv_dr=
_state
>from VSP message
>
>Hi Lorenzo,
>
>Can you take a look at this patch?
>
>Thanks
>
>Long
>
>>Subject: [Patch v4 1/2] PCI: hv: Decouple the func definition in
>>hv_dr_state from VSP message
>>
>>From: Long Li <longli@microsoft.com>
>>
>>hv_dr_state is used to find present PCI devices on the bus. The
>>structure reuses struct pci_function_description from VSP message to desc=
ribe
>a device.
>>
>>To prepare support for pci_function_description v2, decouple this
>>dependence in hv_dr_state so it can work with both v1 and v2 VSP messages=
.
>>
>>There is no functionality change.
>>
>>Signed-off-by: Long Li <longli@microsoft.com>
>>Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>>---
>>Changes
>>v2: Changed some spaces to tabs, changed failure code to -ENOMEM
>>v3: Revised comment for function hv_pci_devices_present(), reformatted
>>patch title
>>v4: Fixed spelling
>>
>> drivers/pci/controller/pci-hyperv.c | 101 +++++++++++++++++++---------
>> 1 file changed, 70 insertions(+), 31 deletions(-)
>>
>>diff --git a/drivers/pci/controller/pci-hyperv.c
>>b/drivers/pci/controller/pci- hyperv.c index f1f300218fab..3b3e1967cf08
>>100644
>>--- a/drivers/pci/controller/pci-hyperv.c
>>+++ b/drivers/pci/controller/pci-hyperv.c
>>@@ -507,10 +507,24 @@ struct hv_dr_work {
>> 	struct hv_pcibus_device *bus;
>> };
>>
>>+struct hv_pcidev_description {
>>+	u16	v_id;	/* vendor ID */
>>+	u16	d_id;	/* device ID */
>>+	u8	rev;
>>+	u8	prog_intf;
>>+	u8	subclass;
>>+	u8	base_class;
>>+	u32	subsystem_id;
>>+	union	win_slot_encoding win_slot;
>>+	u32	ser;	/* serial number */
>>+	u32	flags;
>>+	u16	virtual_numa_node;
>>+};
>>+
>> struct hv_dr_state {
>> 	struct list_head list_entry;
>> 	u32 device_count;
>>-	struct pci_function_description func[0];
>>+	struct hv_pcidev_description func[0];
>> };
>>
>> enum hv_pcichild_state {
>>@@ -527,7 +541,7 @@ struct hv_pci_dev {
>> 	refcount_t refs;
>> 	enum hv_pcichild_state state;
>> 	struct pci_slot *pci_slot;
>>-	struct pci_function_description desc;
>>+	struct hv_pcidev_description desc;
>> 	bool reported_missing;
>> 	struct hv_pcibus_device *hbus;
>> 	struct work_struct wrk;
>>@@ -1862,7 +1876,7 @@ static void q_resource_requirements(void
>>*context, struct pci_response *resp,
>>  * Return: Pointer to the new tracking struct
>>  */
>> static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *h=
bus,
>>-		struct pci_function_description *desc)
>>+		struct hv_pcidev_description *desc)
>> {
>> 	struct hv_pci_dev *hpdev;
>> 	struct pci_child_message *res_req;
>>@@ -1973,7 +1987,7 @@ static void pci_devices_present_work(struct
>>work_struct *work)  {
>> 	u32 child_no;
>> 	bool found;
>>-	struct pci_function_description *new_desc;
>>+	struct hv_pcidev_description *new_desc;
>> 	struct hv_pci_dev *hpdev;
>> 	struct hv_pcibus_device *hbus;
>> 	struct list_head removed;
>>@@ -2090,43 +2104,26 @@ static void pci_devices_present_work(struct
>>work_struct *work)
>> 	put_hvpcibus(hbus);
>> 	kfree(dr);
>> }
>>-
>> /**
>>- * hv_pci_devices_present() - Handles list of new children
>>+ * hv_pci_start_relations_work() - Queue work to start device
>>+ discovery
>>  * @hbus:	Root PCI bus, as understood by this driver
>>- * @relations:	Packet from host listing children
>>+ * @dr:		The list of children returned from host
>>  *
>>- * This function is invoked whenever a new list of devices for
>>- * this bus appears.
>>+ * Return:  0 on success, -errno on failure
>>  */
>>-static void hv_pci_devices_present(struct hv_pcibus_device *hbus,
>>-				   struct pci_bus_relations *relations)
>>+static int hv_pci_start_relations_work(struct hv_pcibus_device *hbus,
>>+				       struct hv_dr_state *dr)
>> {
>>-	struct hv_dr_state *dr;
>> 	struct hv_dr_work *dr_wrk;
>>-	unsigned long flags;
>> 	bool pending_dr;
>>+	unsigned long flags;
>>
>> 	dr_wrk =3D kzalloc(sizeof(*dr_wrk), GFP_NOWAIT);
>> 	if (!dr_wrk)
>>-		return;
>>-
>>-	dr =3D kzalloc(offsetof(struct hv_dr_state, func) +
>>-		     (sizeof(struct pci_function_description) *
>>-		      (relations->device_count)), GFP_NOWAIT);
>>-	if (!dr)  {
>>-		kfree(dr_wrk);
>>-		return;
>>-	}
>>+		return -ENOMEM;
>>
>> 	INIT_WORK(&dr_wrk->wrk, pci_devices_present_work);
>> 	dr_wrk->bus =3D hbus;
>>-	dr->device_count =3D relations->device_count;
>>-	if (dr->device_count !=3D 0) {
>>-		memcpy(dr->func, relations->func,
>>-		       sizeof(struct pci_function_description) *
>>-		       dr->device_count);
>>-	}
>>
>> 	spin_lock_irqsave(&hbus->device_list_lock, flags);
>> 	/*
>>@@ -2144,6 +2141,47 @@ static void hv_pci_devices_present(struct
>>hv_pcibus_device *hbus,
>> 		get_hvpcibus(hbus);
>> 		queue_work(hbus->wq, &dr_wrk->wrk);
>> 	}
>>+
>>+	return 0;
>>+}
>>+
>>+/**
>>+ * hv_pci_devices_present() - Handle list of new children
>>+ * @hbus:	Root PCI bus, as understood by this driver
>>+ * @relations:	Packet from host listing children
>>+ *
>>+ * Process a new list of devices on the bus. The list of devices is
>>+ * discovered by VSP and sent to us via VSP message PCI_BUS_RELATIONS,
>>+ * whenever a new list of devices for this bus appears.
>>+ */
>>+static void hv_pci_devices_present(struct hv_pcibus_device *hbus,
>>+				   struct pci_bus_relations *relations) {
>>+	struct hv_dr_state *dr;
>>+	int i;
>>+
>>+	dr =3D kzalloc(offsetof(struct hv_dr_state, func) +
>>+		     (sizeof(struct hv_pcidev_description) *
>>+		      (relations->device_count)), GFP_NOWAIT);
>>+
>>+	if (!dr)
>>+		return;
>>+
>>+	dr->device_count =3D relations->device_count;
>>+	for (i =3D 0; i < dr->device_count; i++) {
>>+		dr->func[i].v_id =3D relations->func[i].v_id;
>>+		dr->func[i].d_id =3D relations->func[i].d_id;
>>+		dr->func[i].rev =3D relations->func[i].rev;
>>+		dr->func[i].prog_intf =3D relations->func[i].prog_intf;
>>+		dr->func[i].subclass =3D relations->func[i].subclass;
>>+		dr->func[i].base_class =3D relations->func[i].base_class;
>>+		dr->func[i].subsystem_id =3D relations->func[i].subsystem_id;
>>+		dr->func[i].win_slot =3D relations->func[i].win_slot;
>>+		dr->func[i].ser =3D relations->func[i].ser;
>>+	}
>>+
>>+	if (hv_pci_start_relations_work(hbus, dr))
>>+		kfree(dr);
>> }
>>
>> /**
>>@@ -3018,7 +3056,7 @@ static void hv_pci_bus_exit(struct hv_device *hdev)
>> 		struct pci_packet teardown_packet;
>> 		u8 buffer[sizeof(struct pci_message)];
>> 	} pkt;
>>-	struct pci_bus_relations relations;
>>+	struct hv_dr_state *dr;
>> 	struct hv_pci_compl comp_pkt;
>> 	int ret;
>>
>>@@ -3030,8 +3068,9 @@ static void hv_pci_bus_exit(struct hv_device *hdev)
>> 		return;
>>
>> 	/* Delete any children which might still exist. */
>>-	memset(&relations, 0, sizeof(relations));
>>-	hv_pci_devices_present(hbus, &relations);
>>+	dr =3D kzalloc(sizeof(*dr), GFP_KERNEL);
>>+	if (dr && hv_pci_start_relations_work(hbus, dr))
>>+		kfree(dr);
>>
>> 	ret =3D hv_send_resources_released(hdev);
>> 	if (ret)
>>--
>>2.17.1

