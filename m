Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 144EB10F3B3
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Dec 2019 00:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfLBX75 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Dec 2019 18:59:57 -0500
Received: from mail-eopbgr1320110.outbound.protection.outlook.com ([40.107.132.110]:30791
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725775AbfLBX75 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Dec 2019 18:59:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Al1pN+r0zLUWuutcljsXM1hTEevN/xC4d0KDN2EwWHn26/5pWmO8zDVuANIkbVm2RRYqo5zYMLqEdIm3xXhgJmnoisQFbWfKmPiuO9qio7TITboFpOG9ttD4tJV9mTnl65VW7C/RjjDSVEyZRPL35qqW8+cCsrfFBIEc8/v5gba/l7ZrEHSQ/p6jmWb32tlnGMVG9/Jplxg/msOcusd0RvY1ZYvfhWNRFRjl0Sl0sXksDpIVtTIfLMVVYF5T2nNe5A5d3bLrv0/fbqRXUExU3TF7FhFI3iBJith0+q7zEKxn6lH+VmnIBrHNRbaJFGbU4LUcnHj6LF5Owuk6zAa2Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oe2L8bzEnwGmX3GLscAK1iL+8v4xS+dj4heGcxrolHU=;
 b=C0kNYsnGkTHIZiaSjSDEHOHH+1nm2w3IlHaC3782VeVEJAYidAm95nFNu4koFp+msu/nBhpPmsHYZgabaVYUs5+VjvzA13/eMzTelf/KOzF7JCfWovCPWF+gHM1xjF7KAGa4dNBTMF+pL2GVd/POS3qdhbHpjuoTL4odrFptemfXZ/7pZ5p5X14AzxPv9dlceXR3DSD8fMeD5Y/WHFVMj1hVykWRtFvszu/JOHED7mwSe+KJ+nE1K275W2QtxGfU0P2NFkWzVXsrwxmcrDR2lxbC/VXy3dtoLr9JeDk0UJztFgn/q2ibRdJHsdPXdxbGX0uNskj5N/L0ssRE+ecuQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oe2L8bzEnwGmX3GLscAK1iL+8v4xS+dj4heGcxrolHU=;
 b=U9wEliuaUqPlZPue0rYinMeWfEiPE60Ql2JjYmHGnpOi2j/+ddHPA5NThpiRsT8capJRTuo7ek9lgxbUyzVjiI3jZZSmAf00cEvK79w7mBvJxkhfOm0l254Qr1/2bAdLyxtRl50tuItvm/o+GH5oM+B5bhVyv9Ni/cud3LuXVCo=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0106.APCP153.PROD.OUTLOOK.COM (10.170.188.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.0; Mon, 2 Dec 2019 23:59:09 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::704b:f2b6:33d:557a]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::704b:f2b6:33d:557a%9]) with mapi id 15.20.2538.000; Mon, 2 Dec 2019
 23:59:09 +0000
From:   Dexuan Cui <decui@microsoft.com>
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
CC:     Long Li <longli@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH 2/2] PCI: hv: Add support for protocol 1.3 and
 support PCI_BUS_RELATIONS2
Thread-Topic: [EXTERNAL] [PATCH 2/2] PCI: hv: Add support for protocol 1.3 and
 support PCI_BUS_RELATIONS2
Thread-Index: AQHVoaFkXIxw3tqrZk6POfn/+X8rjaenViVA
Date:   Mon, 2 Dec 2019 23:59:09 +0000
Message-ID: <PU1P153MB0169CFE46920BAEEE11CA9B7BF430@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1574474229-44840-1-git-send-email-longli@linuxonhyperv.com>
 <1574474229-44840-2-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1574474229-44840-2-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-12-02T23:59:07.6209316Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f258566e-1d09-4e97-950d-9e44dee110b0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:3:8f1:d9c8:629b:7ac]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d469e003-f1c3-4799-5da5-08d777839f83
x-ms-traffictypediagnostic: PU1P153MB0106:|PU1P153MB0106:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB0106191546EC58344414616ABF430@PU1P153MB0106.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(39860400002)(366004)(346002)(189003)(199004)(33656002)(478600001)(10290500003)(2906002)(4326008)(107886003)(66446008)(64756008)(46003)(66476007)(2201001)(9686003)(55016002)(5660300002)(1511001)(22452003)(316002)(7736002)(305945005)(74316002)(256004)(6436002)(10090500001)(110136005)(52536014)(229853002)(2501003)(99286004)(86362001)(102836004)(186003)(8990500004)(6506007)(71190400001)(71200400001)(81156014)(7696005)(25786009)(76176011)(8936002)(11346002)(446003)(81166006)(8676002)(6116002)(76116006)(66556008)(66946007)(6246003)(14454004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0106;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dXPe3l5ZheOj+jAcRZ9iBtT+ZqpEirKRYI+woxcpqgnBTEellY69RvSPSrGjlJuJCQSv1u041ncnir83zeBhvzhVLlGUzo2tbcQ54Lfb7+mhCFVnrjNP4gNxy02q66RY2x39ffNfRLTE0C4yUOEO9aHu25Uplis/REFAXXRjCNdLJfCPxAfnrJcTzz7U0C7LhppOGJEcsfsxp0nhnBQ5ZPvZ5AHlYD5sZd8mVERikccteNSz3a6sHBp/3FyyHgzbMTcOl6MR1QbIwsLRFDFqgo9RYFhkpvkBcXrfp2fNlurlaReL/a5HgR7yFfjj+PCE5CR8jRAhjRWyTgdYjSuTbo4rPIxZfL4pnckjkxZs3vTQXNT2TJXUpoSFNl9Xwd3UJ5tT2XIofcAMHQf29nJLmXoM1mARnUagS8m4dcPMcYl9hbZ87NvnY9tAk1X/fK6r
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d469e003-f1c3-4799-5da5-08d777839f83
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 23:59:09.2674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZPAiaL7+Ulvk6KRnZIMdxDsQXs8lBKY2VwFBileeHujXAc7acF7XB6D6J/LSNaPovtpVTbCxM/s8LTKHfC8UOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0106
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: linux-hyperv-owner@vger.kernel.org
> Sent: Friday, November 22, 2019 5:57 PM
>  ...
> @@ -63,6 +63,7 @@
>  enum pci_protocol_version_t {
>  	PCI_PROTOCOL_VERSION_1_1 =3D PCI_MAKE_VERSION(1, 1),	/* Win10
> */
>  	PCI_PROTOCOL_VERSION_1_2 =3D PCI_MAKE_VERSION(1, 2),	/* RS1 */
> +	PCI_PROTOCOL_VERSION_1_3 =3D PCI_MAKE_VERSION(1, 3),	/* VB */
>  };

What is "VB" ? Can we use a more meaningful name here? :-)

> +struct pci_function_description2 {
> +	u16	v_id;	/* vendor ID */
> +	u16	d_id;	/* device ID */
> +	u8	rev;
> +	u8	prog_intf;
> +	u8	subclass;
> +	u8	base_class;
> +	u32	subsystem_id;
> +	union win_slot_encoding win_slot;

space -> TAB?

> +/*
> + * Set NUMA node for the devices on the bus
> + */
> +static void pci_assign_numa_node(struct hv_pcibus_device *hbus)

IMO we'd better add a "hv_" prefix to this function's name, otherwise it lo=
oks
more like a generic PCI subsystem API.

> +{
> +	struct pci_dev *dev;
> +	struct pci_bus *bus =3D hbus->pci_bus;
> +	struct hv_pci_dev *hv_dev;
> +
> +	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		hv_dev =3D get_pcichild_wslot(hbus, devfn_to_wslot(dev->devfn));
> +		if (!hv_dev)
> +			continue;
> +
> +		if (hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY)
> +			set_dev_node(&dev->dev, hv_dev->desc.virtual_numa_node);
> +	}
> +}

Can you please give a brief background introduction to dev->numa_node,
e.g. how is it used here? -- is it used when a PCI device driver (e.g. the =
mlx
driver) asks the kernel to allocate memory for DMA, or allocate MSI interru=
pts?
How big is the performance gain in the tests? I'm curious as it looks uncle=
ar
to me how dev->numa_node is used by the PCI subsystem.

Thanks,
-- Dexuan
