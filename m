Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B74910DC54
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 Nov 2019 05:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfK3Epl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 29 Nov 2019 23:45:41 -0500
Received: from mail-eopbgr820133.outbound.protection.outlook.com ([40.107.82.133]:62336
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727142AbfK3Epl (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 29 Nov 2019 23:45:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6FA+l2BVMzOnV5w97DGC7TeODjzt7uqOl1/C0Lz8FELScxh74kf30m5LBVXVJ9u8R7FZgSvqFfbZp3QPPycb6cfMqvSBo0bkYk/QOuMxISOjTaCrm9XiFuxPAPdypeKl/va+IL/OHqaO75/vFqwFTT24YzgIWpwqHuaa/F/PzV+KFVePMbDKYrypNEtLHrDXSjOE8mc6s5LCffvk8SRzMURE+x4z4rNb1GCxvUXuAymYHuuLLSKaVqSO5iY2KUBPbMnCOGfWIfakK/YROD6luGE9tK9zhfzcos+AYDzg0VQcduAwUcUDDIbKoP5KD57G/iscA7rGkfWNfhpdQ0Vew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Co3l934DCYq+zxn8eiJTpMW9eC9dClm6JOgjJK0S34=;
 b=C0Zy0wsmFFKe7ahxaIGIjlqgcyPAsCowqGP8QrJ/Z3OTh6z4ZGzeMQQz8wa0V7UeazVgOPtlOQmqnVKYZn1aoMv2QNizFCC8/6M69JBHCHfaL9BnwtjL/iFzifpqpElN1MRkxoBZfckqZlYReylKWhG+ujo31uwy2y42t8EivfgnVnObojAWDSRrGP8f4CY9aIs1rt1O+tnYwS6HRsZrCv6pySiQU669LKvKfGBjaaSRPyZXTKoYTj3N+xyySN3TpnSUASWabFat3RXIKWve/Apflh2Mnc0hg9wC7Vw7vxTISJXQrF2ZpdBN0wNit1FjH78qoqZ4pRwjq9Y2rIin2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Co3l934DCYq+zxn8eiJTpMW9eC9dClm6JOgjJK0S34=;
 b=KlB8vWTVKpg3AXlVszgVq29ZhC72a/344WeoyL7doJGDI9MFHPh2Os+syhH2SBrckRo6FDRiQllrJDopgugocnvaT7iZy7EW8mQniDsmHAqXAtFNwusmESW2QSNR88pcOP3jXRSWvgDe4NzZYx8yet+8w2DbGz5KM1+PvbrW+EY=
Received: from CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.8; Sat, 30 Nov 2019 04:45:36 +0000
Received: from CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::ed94:4b6d:5371:285c]) by CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::ed94:4b6d:5371:285c%4]) with mapi id 15.20.2516.003; Sat, 30 Nov 2019
 04:45:36 +0000
From:   Michael Kelley <mikelley@microsoft.com>
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
CC:     Long Li <longli@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH 2/2] PCI: hv: Add support for protocol 1.3 and
 support PCI_BUS_RELATIONS2
Thread-Topic: [EXTERNAL] [PATCH 2/2] PCI: hv: Add support for protocol 1.3 and
 support PCI_BUS_RELATIONS2
Thread-Index: AQHVoaFeiJWyuTLLsUiMTX6LeRJTSaejKm4Q
Date:   Sat, 30 Nov 2019 04:45:36 +0000
Message-ID: <CY4PR21MB0629300E161C5119D4714A64D7410@CY4PR21MB0629.namprd21.prod.outlook.com>
References: <1574474229-44840-1-git-send-email-longli@linuxonhyperv.com>
 <1574474229-44840-2-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1574474229-44840-2-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-11-30T04:45:34.1746665Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0f1b8475-7cee-41ba-9596-da3f0b1969db;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2e2c4505-ba3b-4ad6-3064-08d77550243a
x-ms-traffictypediagnostic: CY4PR21MB0469:|CY4PR21MB0469:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR21MB04696F31075A2D89BAB6A4DFD7410@CY4PR21MB0469.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02379661A3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(366004)(376002)(346002)(396003)(189003)(199004)(26005)(66446008)(6116002)(6436002)(316002)(5660300002)(81156014)(478600001)(6636002)(86362001)(7696005)(14454004)(33656002)(10290500003)(66556008)(66476007)(8936002)(52536014)(66946007)(64756008)(6246003)(76116006)(229853002)(3846002)(25786009)(8676002)(107886003)(4326008)(81166006)(102836004)(256004)(74316002)(71190400001)(22452003)(7736002)(110136005)(2201001)(99286004)(66066001)(10090500001)(76176011)(186003)(55016002)(6506007)(11346002)(8990500004)(2501003)(2906002)(446003)(1511001)(71200400001)(9686003)(305945005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0629.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u7/18sKmb5VKQMckFMDPBtAtcLwcWgrioJCkjKwfH0iMnzKnJwlNQlD4uF8Sxx341DYC++ZYV8I+vkNvZutkx1g3v+dsTw1Xu2LzE5UtlrrnBjjQbkZx8AOjj0zmzHwYBCAcL4J6WtBfAYlJbIPYDT6ggtO1Ccot/FNVZgb5O29g1+YWWEWhjkmK+qn97yT3YxHhCUSQNc/US8Ja0TMqdwyE3bmctVJhrCCzuVGHxwu/jVwc67MoSwqpxJ3VDpkGTeLQEw0iLnuHLNY153NEP1yP8YcUxIbKTyBxcZNkNWtm2Zw3XUCRP3puWbQjIqt/ri2vqwZ9tliqkiSXgdrSRrbEUThaTIfapXtUkzijyOBuvnKl6RvLEMRAW7fLzaobtMWbZHReQxgir7UxUwhrcZNLnpq/K8WCVHOVoIYv7DaNx/rv1eTbL+ZV5UEyNG/e
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2c4505-ba3b-4ad6-3064-08d77550243a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2019 04:45:36.0331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: APPH3jg5OEbrEfCdR5edo8kq2JbLwXgqzmd+yGpzUipzf1Va/I9ZiSlx48R6Xm9mBbyReuY7ZZDaBbqHgGKoqJE4Su0bvR37TbbhRP8h+6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: longli@linuxonhyperv.com Sent: Friday, November 22, 2019 5:57 PM
>=20
> From: Long Li <longli@microsoft.com>
>=20
> Starting with Hyper-V PCI protocol version 1.3, the host VSP can send
> PCI_BUS_RELATIONS2 and pass the vNUMA node information for devices on the=
 bus.
> The vNUMA node tells which guest NUMA node this device is on based on gue=
st
> VM configuration topology and physical device inforamtion.
>=20
> The patch adds code to negotiate v1.3 and process PCI_BUS_RELATIONS2.
>=20
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 107 ++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
>=20

[snip]

> +/*
> + * Set NUMA node for the devices on the bus
> + */
> +static void pci_assign_numa_node(struct hv_pcibus_device *hbus)
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
> +

get_pcichild_wslot() gets a reference to the hv_dev, so a call to put_pcich=
ild() is
needed to balance.

But more broadly, is the call to set_dev_node() operating on the correct
struct device?  There's a struct device in the struct hv_device, and also o=
ne in the
struct pci_dev.  Everything in this module seems to be operating on the for=
mer.
For example, all the dev_err() calls identify the struct device in struct h=
v_device.
And enumerating all the devices on a virtual PCI bus is done by iterating t=
hrough
the hbus->children list, not the bus->devices list.  I don't completely und=
erstand
the interplay between the two struct device entries, but the difference mak=
es
me wonder if the above code should be setting the NUMA node on the struct
device that's in struct hv_device.

Michael
