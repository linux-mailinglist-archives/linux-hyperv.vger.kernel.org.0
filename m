Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07151C8F83
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2020 16:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgEGOcm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 May 2020 10:32:42 -0400
Received: from mail-mw2nam12on2120.outbound.protection.outlook.com ([40.107.244.120]:9770
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728572AbgEGO3q (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 May 2020 10:29:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuGvBkLpNWE1g4Tu3toGspr2rTn/c5nd6dB9uNu60d9k1T13Fi6deFrrBY1i+sk6eBU2AULAm6/3Ju1DLATy/Q3kr4rl2EdQ4FAXANIumKTbaeE9yY3Xdxp5o5J5jIJHokiD7XZlN08Kz2K1sNcTgbkMS4UblAbUFlH3oSHrBpJx8cXlsIiAGAk7pu0bE24Qjkapud29PTETRJGr//17Wrrjjz8vqfKYPfWFh4v4lH11P4j6jkc+dhCP5NzgTbjhEHybiaaUWbosMhr68XL6bAj5K1LGhipnHj11jNCGBNds9cTyF0v4qLhdM8tMYj1H59sFaiC3LhKUp2irWn8hWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBfFSvZKYgZpPuzpewabK71xZ8DcByMxnflgrXzh9sk=;
 b=ONlVwkW9MG8P/mg9GsFEp8Aw6IdqZC5jLvRgs7MvKfU4JzXmZOBKacJwqfJXurII7awAxg5v4FYcLCI+53p70F5ozRylun3x2i1s+LYIzoZmJj2Gyigiar/XRf/fcI2M9JzWDf/M0o0RK9/ueIJVM1zUpLuRMES6ThN6j4sJ2JmPvZwNA8qFG3cgKo3MMnjKvP5bGtNU8yJX59lcNPGTuL8f6kvSgK3V5yajR+Q0XUfLfYrDHo13wQx0TyYgXZQl9gAZGST2IjrCbh87xivvCV3rySkaQwuwls3T4cHumin7ujjZedCXSlJ18vjeEckuAEOknxNxfrfzFoYFYRS92g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBfFSvZKYgZpPuzpewabK71xZ8DcByMxnflgrXzh9sk=;
 b=ez7Ybq+yIdQTYN0f1g1/XCNZLPLRUN79NvFixLuzA7FoWgo2bvSSUAwk7R3v5/KXtGGxQZi9BnXnWBoRZ8X11kOmawraSNcr3R9flFSn4eiw70OXkm01n7/9Dp3PhZvtjUN50+M/3oHazgMyW3O9uIyH5CZ3T3yxGfX5aOr8g4U=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MWHPR21MB0830.namprd21.prod.outlook.com (2603:10b6:300:76::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.3; Thu, 7 May
 2020 14:29:36 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::5a3:a5e0:1e3c:e950]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::5a3:a5e0:1e3c:e950%5]) with mapi id 15.20.3000.007; Thu, 7 May 2020
 14:29:36 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Hu <weh@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v3 1/2] PCI: hv: Fix the PCI HyperV probe failure path to
 release resource properly
Thread-Topic: [PATCH v3 1/2] PCI: hv: Fix the PCI HyperV probe failure path to
 release resource properly
Thread-Index: AQHWJCy9PqPO+JnOKk+Vdq8KR6HdUKicrzSA
Date:   Thu, 7 May 2020 14:29:36 +0000
Message-ID: <MW2PR2101MB1052E75BB228D7AF499B6135D7A50@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200507050211.10923-1-weh@microsoft.com>
In-Reply-To: <20200507050211.10923-1-weh@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-05-07T14:29:34.7675619Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=12599c13-359f-475a-9826-c99ab87e02d1;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a5e5752b-2a55-419c-6f06-08d7f29311bb
x-ms-traffictypediagnostic: MWHPR21MB0830:|MWHPR21MB0830:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB08300BAA02B44E1643DA3E1FD7A50@MWHPR21MB0830.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 03965EFC76
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ywmY9geSxxlDX7l498pmj45I/moedW4/2afNpKbuRK7ljz8mtU8h0FzIWvAoTEUP6Hhv2V82M9hb/ZHPPIEg9nwz4EtHcwtgONA5YM0R7GujEHCYXvTpCalq/4SGYknw5afKeWTL+qQVCE43ic3rgdXjYHa6rX7V5gVssIkqq4DK82U6QRtxelBSGtggXKWqylhSe/QrH2jIU66cW+bgGob/jg4Gv+jSHnDuSgQxK4r4ZuoL3aivaYNSq1q/jeER4YZ7ebpYKasKIHBtafsH4wXfTEesTQnDWTku0b6U1HQAG9YA1ZRt35lHYNJ9CUZmt5Br9yKkaLatOpgY5Ok06MpknZ+Wn72elf/WNA89iilUzVC6thTUV7WKADKGUk/w8r/sO/CUQk4n01Houxv/qxX1kRoreOuSLj+/UbMIlMPG8T+yd/M6GJyNgMeMJvYFhG+MNz0ziHjRGJU/Y32lSwg73n0Z+VLFjyAsWrPZaQAQhVrk4/LRGT5sbdEWP7GEDj/5mbl5401lmd5bIFGdnTSjogj+5qP41VX2DYeRDxM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(33430700001)(9686003)(33440700001)(64756008)(52536014)(8990500004)(6636002)(66946007)(83300400001)(66556008)(83320400001)(83280400001)(83310400001)(83290400001)(66446008)(66476007)(76116006)(5660300002)(33656002)(2906002)(6506007)(316002)(55016002)(8676002)(71200400001)(86362001)(478600001)(186003)(10290500003)(110136005)(8936002)(26005)(7696005)(82960400001)(82950400001)(921003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: fm4rHAcMBtEBoVHEZe5SFtDjsxTHNBiDXCMHIeFr46gjYRReR9m6Fe3XBd0u3RKhgCTuwvIFZjt6TmO9ALz8jHvvlcGm/ukk49wMWZtd7Evgy/HHiUMGU0YE3+yBk/1IDxD8sJiPvoDzq8htsmsSCOqgCJiUUfMmymB+0EYSEF/WwoRUkPsTlWnFd1WLbo2z8t/7XJCGV2uZljts5jjgk6zTljVZK5Cg2oDxru4R/zo93etW4BjhOYqIlM2MezliXdxQV1Qpc7RdS+MCLP5M0Ui++eo0tAL7F0Vk7ttMGj/3p5OagDsi0xSQroNZAy+ydoyi2bYq3H4lQOQb5zrOQkqJhJjapPMrCd4dBAAINVTECDVpz4tq86abMamhmK2/AymtQs9KTy87TJCiIe1fFoNNRHVBWNJoIQy4sZoOAIMUXPorQ77FWZhTkgwSFZI2DH83wPc///kQWc09ZNmjglct3qmyUDsaOyoC3lpb7UeYU5X3IOur+NVz9u5wLFN0O2X5fa0nuraU3FHTAwA2y8T8UavDz2FE6mpX+/Jk829F3ZmOSgw7FmQDqZ0Zp/NWTNEaHuAkY7ttdp6kDotFUxDgFnMtRAVZWEzPqXwZ1yt44QGbQ5VnGQxJehda+e5jaiPbJN66/yJFpAX77b+amI6E8IghDHJpHJUoKvA8gDqZVMk2EQ8AMyQls8+W0oQgMDbPXWbCFltpimnGrLdd7uAv5VHvvgMI9QcYBQvL7ul1uzyDuKd3F1zn7+omVf1aOitFDOuMzpuoE1zOpomvz9JCD6PtQQm8JoGGTKR097g=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e5752b-2a55-419c-6f06-08d7f29311bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2020 14:29:36.3977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zKsYgwZsCHpK/xdBgmgIa6WFS+nIj/zlu0USZYRpfiI6InZLPz5d0C/JxBDsVJRgu9hbWrLSxafDEfEPGd8zDlrM16rMa8fqdljZ32I371Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0830
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Hu <weh@microsoft.com> Sent: Wednesday, May 6, 2020 10:02 PM
>=20
> In some error cases in hv_pci_probe(), allocated resources are not freed.
> Fix this by adding a field to keep track of the high water mark for slots
> that have resources allocated to them.  In case of an error, this high
> water mark is used to know which slots have resources that must be releas=
ed.
> Since slots are numbered starting with zero, a value of -1 indicates no
> slots have been allocated resources.  There may be unused slots in the ra=
nge
> between slot 0 and the high water mark slot, but these slots are already
> ignored by the existing code in the allocate and release loops with the c=
all
> to get_pcichild_wslot().
>=20
> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---
>     v3: Add detailed explanation of this patch in commit log per Lorenzo
>     Pieralisi's suggestions.
>=20
>  drivers/pci/controller/pci-hyperv.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index e15022ff63e3..e6fac0187722 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -480,6 +480,9 @@ struct hv_pcibus_device {
>=20
>  	struct workqueue_struct *wq;
>=20
> +	/* Highest slot of child device with resources allocated */
> +	int wslot_res_allocated;
> +
>  	/* hypercall arg, must not cross page boundary */
>  	struct hv_retarget_device_interrupt retarget_msi_interrupt_params;
>=20
> @@ -2847,7 +2850,7 @@ static int hv_send_resources_allocated(struct hv_de=
vice *hdev)
>  	struct hv_pci_dev *hpdev;
>  	struct pci_packet *pkt;
>  	size_t size_res;
> -	u32 wslot;
> +	int wslot;
>  	int ret;
>=20
>  	size_res =3D (hbus->protocol_version < PCI_PROTOCOL_VERSION_1_2)
> @@ -2900,6 +2903,8 @@ static int hv_send_resources_allocated(struct hv_de=
vice *hdev)
>  				comp_pkt.completion_status);
>  			break;
>  		}
> +
> +		hbus->wslot_res_allocated =3D wslot;
>  	}
>=20
>  	kfree(pkt);
> @@ -2918,10 +2923,10 @@ static int hv_send_resources_released(struct hv_d=
evice *hdev)
>  	struct hv_pcibus_device *hbus =3D hv_get_drvdata(hdev);
>  	struct pci_child_message pkt;
>  	struct hv_pci_dev *hpdev;
> -	u32 wslot;
> +	int wslot;
>  	int ret;
>=20
> -	for (wslot =3D 0; wslot < 256; wslot++) {
> +	for (wslot =3D hbus->wslot_res_allocated; wslot >=3D 0; wslot--) {
>  		hpdev =3D get_pcichild_wslot(hbus, wslot);
>  		if (!hpdev)
>  			continue;
> @@ -2936,8 +2941,12 @@ static int hv_send_resources_released(struct hv_de=
vice *hdev)
>  				       VM_PKT_DATA_INBAND, 0);
>  		if (ret)
>  			return ret;
> +
> +		hbus->wslot_res_allocated =3D wslot - 1;
>  	}
>=20
> +	hbus->wslot_res_allocated =3D -1;
> +
>  	return 0;
>  }
>=20
> @@ -3037,6 +3046,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	if (!hbus)
>  		return -ENOMEM;
>  	hbus->state =3D hv_pcibus_init;
> +	hbus->wslot_res_allocated =3D -1;
>=20
>  	/*
>  	 * The PCI bus "domain" is what is called "segment" in ACPI and other
> @@ -3136,7 +3146,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>=20
>  	ret =3D hv_pci_allocate_bridge_windows(hbus);
>  	if (ret)
> -		goto free_irq_domain;
> +		goto exit_d0;
>=20
>  	ret =3D hv_send_resources_allocated(hdev);
>  	if (ret)
> @@ -3154,6 +3164,8 @@ static int hv_pci_probe(struct hv_device *hdev,
>=20
>  free_windows:
>  	hv_pci_free_bridge_windows(hbus);
> +exit_d0:
> +	(void) hv_pci_bus_exit(hdev, true);
>  free_irq_domain:
>  	irq_domain_remove(hbus->irq_domain);
>  free_fwnode:
> --
> 2.20.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
