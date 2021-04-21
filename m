Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F2A3673CF
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Apr 2021 21:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbhDUT5a (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Apr 2021 15:57:30 -0400
Received: from mail-eopbgr690106.outbound.protection.outlook.com ([40.107.69.106]:42787
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235767AbhDUT53 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Apr 2021 15:57:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bluNk31FRNE1gTkJfi7Di1qiRVNTd8dXmZB34irkmGjCNnwRsIusQ+QPcfVJXZR/5C1lj/dMLFf/Uvla6wpjn6I0tv8em2lXDg9VsyNejTo16CVJYlekYWpALATiNHec/r8/hRTKKMJt2BM2rf5T33fvvAiMWhRkSbRQKrVF+dUrNmKlU3PDiPyoohJA7EZ6kYwYoMplxY0yGw7De781NCKvOSm43FBIWf8C1Wp70vF/YhaM2U5gCKxIIns03vZ6YbX4tyC1SWZPLUubvoYWxLg9Hv0NylZMnxNbsFYq8v9D0/iAWQh8t+OwtUEqQdR6PrcQzXCu+4LvPq9DWt7dpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7Q4xj370xBczS6u+70n8//7czkVyrWL9HCgQuilRZc=;
 b=VRzoZSdUg/13XRox1a6BckdJ2z/d3x0shDO25ptnDXKr7lkTgxKYfcRYpQFfrnquYlgiVIrORJHSEIt+nZ2JB8YHaZfbwyMS3R0r/+TSLl3lcWRirSKcWdARGgjx17YVk0Y/8XOigKLwELnib1TBEEmRUHbDksUkpfQ5c68pLD5S0Qu3vr9wBSIQi2ihEE3FZY1WqNydT/JbNevRmgUIuK/Z7nT/htNgqDrp6PL55DEFXlsYqmm0lT8fPe76NMEZrktSysq5IlKytduskNiWVs78mzH9dmxPkE67xvX/yQVsvqrgjHFyZQy1pAU9fE1Ajmjwpnn7ExmZEwL2RKZywA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7Q4xj370xBczS6u+70n8//7czkVyrWL9HCgQuilRZc=;
 b=HIWvMG8IS3yahFiK7Hz03Lv7G6M0ACOQ4I40Fp6BALaxaSDikkHnXH5pN3opCvSa8plBUAIb4qyII9vRD9l92/PbIrCpy8wcxHYnB5zOgTpZKi7brvJyK/3oP7s/ZcjamPf7rjLfoVjQxFdBZ3l1cOF/V/OmyPWXtXzTSVe01V4=
Received: from BYAPR21MB1271.namprd21.prod.outlook.com (2603:10b6:a03:109::27)
 by BYAPR21MB1158.namprd21.prod.outlook.com (2603:10b6:a03:104::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.7; Wed, 21 Apr
 2021 19:56:54 +0000
Received: from BYAPR21MB1271.namprd21.prod.outlook.com
 ([fe80::c074:b476:d8d6:4e86]) by BYAPR21MB1271.namprd21.prod.outlook.com
 ([fe80::c074:b476:d8d6:4e86%9]) with mapi id 15.20.4087.016; Wed, 21 Apr 2021
 19:56:54 +0000
From:   Long Li <longli@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] PCI: hv: Fix a race condition when removing the device
Thread-Topic: [PATCH] PCI: hv: Fix a race condition when removing the device
Thread-Index: AQHXNVHkJ0PNV1hvE0ut3i0wELJaQKq/Pj6AgAAGzVA=
Date:   Wed, 21 Apr 2021 19:56:54 +0000
Message-ID: <BYAPR21MB12711AF8B782FAA4B492D0CFCE479@BYAPR21MB1271.namprd21.prod.outlook.com>
References: <1618860054-928-1-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB1593CAEAFB8988ECB93BE6E3D7479@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB1593CAEAFB8988ECB93BE6E3D7479@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0c2cd82d-a9ce-4184-9a5b-6c1855cc9093;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-21T17:24:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [76.22.9.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c61a3d81-de59-4ece-6a79-08d904ff9d11
x-ms-traffictypediagnostic: BYAPR21MB1158:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR21MB115802CB73F62EBB50343BB7CE479@BYAPR21MB1158.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g5zNrPmWGmJajexECQyA5pFNE8BB1QFMADokMxVCQcF+TUUXZ5Slrtaga5NiiDTFdaMNZvMG5NMMvog8Ul+ad+aAbKZF6hEpfizKkw/kIrRxkGC1GSDjiCiNVLH5sU2Z6PqNcoHmWb0Efr/4myG5hCXQ7DpY01uMLDYOIGZvQr36kzqVAqeT4c3cC5Y+tZ0EEacYt5VZuSiPek7C1gH2jdj5xUUXughZiZFjhTmZNw8QK3LOQ/S6OFWAG19qwUby/YwLC3q9vw6HxNKpFo5AR2VFJpSJXBfk6b2x+X89UQPbHKiSeNhfMXg2XZ8vgSK0ymeI0GjuaVTH/FiOqwmifLq7kZfqy3/x02VaQYTG43BLcZh/uBacIQTZJaooLIrsgEkQyYi9XjAiEXrXHGSXZxE297b0x6+tEP8QERnxs/RKiVQWAM/hKDvL9EiY5zHeKKp23NeYWHMa7tzSs0Pi+/X5GKh9bA9kD3TGRRJ6XqhCWzy58SyFWZWOJhaeguNnTCjzX0stPejWdekA/mUEX1pnshEHDepiFrjRRqhM4Ow+8oEcXN0S4ln25ZwzhYDmxSQsrDG5tS5RAdvTOUx0aDAmXS3OviUHwzEVkk0ESU/Dohb95sq8hNMQ0RO5tF+BJgIaa0WoDILndgRi76qbtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1271.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(82950400001)(82960400001)(33656002)(52536014)(921005)(7696005)(55016002)(86362001)(8936002)(5660300002)(6506007)(9686003)(6636002)(2906002)(8676002)(478600001)(64756008)(110136005)(26005)(66946007)(66446008)(186003)(66556008)(76116006)(10290500003)(8990500004)(316002)(66476007)(122000001)(83380400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QvEj8gRo1xNuBOn0KUv/z0kWq5xmei6HEj5WADaPxLi/5LHa2vjmMekE85FI?=
 =?us-ascii?Q?i2bTQ8r5ZMjw2gV5JCnvL/bYQLqNWJVT7snSsNbNwtw2sUp3qjbGOlsFAf9z?=
 =?us-ascii?Q?izAZLK+wn7ymSPhe0uKpgJIy5bi4kK2NAl8sUZ6CIf4mrTctgjc8+dCY94KZ?=
 =?us-ascii?Q?mc+v/yoOwKZttZ05JWyEZEnkbeCLQSyuuCG44z1iC/1NZY7LnH6aKdXVXGKp?=
 =?us-ascii?Q?c6UJiTpnZRouDOq5j2axhZluBIeSAa8g8FGRF0npIfsarVEfTETbLILXKS8W?=
 =?us-ascii?Q?gkRdDZBZ0WfIxHZ4Q+UHkybxEiD5M8s0m/7Lc3xH6txJDWXeGcky9c1Ufi1b?=
 =?us-ascii?Q?cW6ZOkDqgikKX9spmcLDcSr6Ji1lcL+tZFRwqdDMX1h1KCLNXBxeD15vPByJ?=
 =?us-ascii?Q?AMbkT/351+wFPzr533hDNJxy+PT1CRN3GO3Xbur8Z+RMNeWewDVftBm0LneQ?=
 =?us-ascii?Q?JhTVG3rOKhd6zok56jqiw7h46J0XC9bJxCbJ8yZkDhk3PpMx3h9ROWEEoKjs?=
 =?us-ascii?Q?L+zbO9QRXaCc4VU/2XNSiMhpZ8xLco7PLbSW2Fj/DPjac3f4AgKfKASG4Mvp?=
 =?us-ascii?Q?RnYm+ctVSojhSVKLZ+pd5dYlDX/5qVmDJn70Rvw26Y2pnwh1u4KuIbI4FsuH?=
 =?us-ascii?Q?aGzuTh59EpikhslZEN44brcLYs18Z059KNdXAXNRiA6iT5IlDQDkhYQvYNOa?=
 =?us-ascii?Q?Kfd/5HkdADEkGOD2FeYsQO8BTpjBSVU07HmZ+PlOrvc2eXBogp2cGQl2gtSX?=
 =?us-ascii?Q?APrAtkFYNITSHzMfIhyU/GFnTQi3Io68cBba1jB6hvi/ejwwNc+b+uOSK0U0?=
 =?us-ascii?Q?RrJoIHZ3H7MTK6czgBWy6Gt+cjABn2NrnQaIfAt0H+MZwoxEbxNmCIkZ4Oud?=
 =?us-ascii?Q?gFNQSUqseWE3KY/zCMMr5ByJRDLP+4QBBIy0FkQDkHLFP9QSNIDNz7igkBlH?=
 =?us-ascii?Q?hj5roneoGRz52PNZ+toddUpfJS/F+ybGwTXdKWU0MFaEYlq2Rdw7qex4Z4GM?=
 =?us-ascii?Q?fFhmk3In0sMtgRoqfnzFRBdAkWzor/YUVL9rS/TLrDFd/EUuP6FQMM1I9Dd6?=
 =?us-ascii?Q?Z2XvAaDzdl0j49iqk3Sfi8SRKvA4kP47scCYngmwxcdubLi9YXnUI/tQ0zLs?=
 =?us-ascii?Q?JFuJMJpeahmGiweLqn6T/wxmgFooFDLl6pW/El7FJOeBf4LXBQva/8DqNqWr?=
 =?us-ascii?Q?r03e4nit0zjNDfT1pKPBd9snLfFE6M3tHkfJuTZTYElOsErUB11E1OD3ult7?=
 =?us-ascii?Q?nXQSNVzi5xwR/fwjtPlzHA1Wt1sQdkmRzIP31cOUNAO4XEpcabV2FXxmP2g1?=
 =?us-ascii?Q?S4E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1271.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c61a3d81-de59-4ece-6a79-08d904ff9d11
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 19:56:54.6612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WbVHkxGyYDCaIJdAOB1XVxbg5Av/ec3RhX22rD0NukgLGeWNXEfGSADsXe+uraFpWvjTCahTgw9ovWASwIMDnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1158
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: RE: [PATCH] PCI: hv: Fix a race condition when removing the devi=
ce
>=20
> From: longli@linuxonhyperv.com <longli@linuxonhyperv.com>  Sent:
> Monday, April 19, 2021 12:21 PM
> >
> > On removing the device, any work item (hv_pci_devices_present() or
> > hv_pci_eject_device()) scheduled on workqueue hbus->wq may still be
> > running and race with hv_pci_remove().
> >
> > This can happen because the host may send PCI_EJECT or
> > PCI_BUS_RELATIONS(2) and decide to rescind the channel immediately
> after that.
> >
> > Fix this by flushing/stopping the workqueue of hbus before doing hbus
> remove.
>=20
> I can see that this change follows the same pattern as in hv_pci_suspend(=
).
> The
> comments there give a full explanation of the issue and the solution.  Bu=
t
> interestingly, the current code also has a reference count mechanism on t=
he
> hbus.  And code near the end of hv_pci_remove() decrements the reference
> count and then waits for all users to finish before destroying the workqu=
eue.
> With this change, is this reference counting mechanism still needed?   If=
 the
> workqueue has already been emptied, it seems like the
> wait_for_completion() near the end of hv_pci_remove() would never be
> waiting for anything.  It makes me wonder if moving the reference count
> checking code from near the end of
> hv_pci_remove() up to near the beginning would solve the problem as well
> (and maybe in hv_pci_suspend also?).

Yes I think put_hvpcibus() and get_hvpcibus() can be removed, as we have ch=
anged to use a dedicated workqueue for hbus since they were introduced.

But we still need to call tasklet_disable/enable() the same way hv_pci_susp=
end() does, the reason is that we need to protect hbus->state. This value n=
eeds to be consistent for the driver. For example, a CPU may decide to sche=
dule a work on a work queue that we just flushed or destroyed, by reading t=
he wrong hbus->state.

>=20
> Michael
>=20
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> >  drivers/pci/controller/pci-hyperv.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pci-hyperv.c
> > b/drivers/pci/controller/pci-hyperv.c
> > index 27a17a1e4a7c..116815404313 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -3305,6 +3305,17 @@ static int hv_pci_remove(struct hv_device
> > *hdev)
> >
> >  	hbus =3D hv_get_drvdata(hdev);
> >  	if (hbus->state =3D=3D hv_pcibus_installed) {
> > +		tasklet_disable(&hdev->channel->callback_event);
> > +		hbus->state =3D hv_pcibus_removing;
> > +		tasklet_enable(&hdev->channel->callback_event);
> > +
> > +		flush_workqueue(hbus->wq);
> > +		/*
> > +		 * At this point, no work is running or can be scheduled
> > +		 * on hbus-wq. We can't race with hv_pci_devices_present()
> > +		 * or hv_pci_eject_device(), it's safe to proceed.
> > +		 */
> > +
> >  		/* Remove the bus from PCI's point of view. */
> >  		pci_lock_rescan_remove();
> >  		pci_stop_root_bus(hbus->pci_bus);
> > --
> > 2.27.0

