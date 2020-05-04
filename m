Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE95D1C4A7D
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 May 2020 01:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgEDXm5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 4 May 2020 19:42:57 -0400
Received: from mail-eopbgr680100.outbound.protection.outlook.com ([40.107.68.100]:15545
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726911AbgEDXm4 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 4 May 2020 19:42:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xhno9Pq7OWrU7Z0xoAvVnbklaRphgfO0uwDKu+ZmTfw3W4KMOnx1+OBZ3Sq/izw723igjz3jOR+Rc4vK3Ff7WhhsFQFxJNll7cFyEH6/3v+9ljbtKP5VTynvv81EYFsGgosoCgNBrHvk72AaVgf11yHxHvJPYyi+S3dCXPMzAFKMCef/4JYPSunnxYPDQKaQE1jPvXcYfdcdoVP+KYr/gQFxbZwvdLB8EriDMIbQTMaXsHLBw+9aDYn1685az1lougT4vOWii4ce3aHhp4ccrKTYLWdJqumag8oYOxm21TPk65I/Ywcrb/bubxpl3d2vBExF8UvHEAD0Dr32rBMeKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh20Dlc0Nm4G1nNtXPyVOSLKBCL7GLPCHfLqDTMbVnc=;
 b=kelv5mfvbnkaHH+7ZldPpMH8BgGCp/Oxo2wVvqw2G5bTWOSUwGGUCeT7/jBUgf2XLqxWi+so/mOndIJbkm+EahcsNBr9elzr53mo9t/jvqnPbZqgiN8kfvt8pkKfXWZYfxi2oHsxC8gQjcHbPU9n5iXWQpRDs6gEKJqSx7cbXzkLG1T+C/tJmU4+hT6hZmZGrpUhXnuYDuZbTD3VZvH9m+t74ZA81RNNgo/hIF5MyJ+J53rHshgErFQxGIu+ZbGoAazx3J4G8LUIgf/H4X7b48lsFO69dJ4buQ2+Sp7RmKGly1HhPDlU2wanLcEcoeLL9L6asqNZBkfrff24WwyxvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh20Dlc0Nm4G1nNtXPyVOSLKBCL7GLPCHfLqDTMbVnc=;
 b=IkkoHRY24AqRi2UF39KEHdBItBFGGS6mJ0WshXbX18UprMPe5PQDDbIbA/90axoVr3qWx7MFE3DGIcV9nS5hdgHusnv6t03oHDIgAXDE23+24/6U5rWv5CHgm13kW/VCh0KCOH9I8pOxFylOxqJzs9qBq1zVmKbhY8h0KngKG5c=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1004.namprd21.prod.outlook.com (2603:10b6:302:4::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.3; Mon, 4 May
 2020 23:42:52 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::5a3:a5e0:1e3c:e950]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::5a3:a5e0:1e3c:e950%5]) with mapi id 15.20.3000.007; Mon, 4 May 2020
 23:42:52 +0000
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
Subject: RE: [PATCH v2 1/2] PCI: hv: Fix the PCI HyperV probe failure path to
 release resource properly
Thread-Topic: [PATCH v2 1/2] PCI: hv: Fix the PCI HyperV probe failure path to
 release resource properly
Thread-Index: AQHWH3qC9OKP6NPAT0GaOvO53wpTCqiYnDPQ
Date:   Mon, 4 May 2020 23:42:52 +0000
Message-ID: <MW2PR2101MB105228765AB647C8A9442738D7A60@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200501053617.24689-1-weh@microsoft.com>
In-Reply-To: <20200501053617.24689-1-weh@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-05-04T23:42:50.1999929Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4f9a484e-914b-4e2a-ab7d-622f4a64509f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 81ba272c-f228-41a1-6b99-08d7f084dca0
x-ms-traffictypediagnostic: MW2PR2101MB1004:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1004E448D1BBC8A2D5B9A193D7A60@MW2PR2101MB1004.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 03932714EB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nyMMPYSmct+CTmSMRsF86xBFyh7gzHvGw0aFimpFlgnTCCf9143//Biqcya0AVL5RBYG2dtfwEu/R0uDoFa82DmHobOB+t1pcrgV5muFB4fV53moyve64pqpVkzFon2XqbkgZchND3qY+erubVSCnOh6DPQieMjawVMkkVCKzUK8JhWMZAsqv1qgbGhRCH9eVMG2CVpsc/INJ+vxn/NzE/F34+T26BxXcZ5tTmMCnJMoIFtf3mL7nFxxcHBDNTYJqtcXMdaNC7OXn7tj/XTQ7moQak02rcHFmVg5gzlqnP/XN3UuTmzGynZV2jNxE0zerlMQO0MMHwTD1UbSK5XhZmgMFNZyP4mFvjaojaa5XyNGh5DCktjJNKPBPq5sbzv5W9HW5gDYxIldFtf4IL8Y1NR+KUF2tsp5L/dWHkWO3YnZRTTgv8uwJxBDX6ThwP8V2zwbsy899/JacNVDZvHDm1PWJl50vXWMVBAFMzlAnp7f155ffuIjuPc7dZi7lCgyNvPuQcxDKfW4ncuhZmcIiReg8tPmMo7bHr1HCf56OZc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(33430700001)(76116006)(7696005)(66946007)(478600001)(6636002)(2906002)(66446008)(66556008)(66476007)(82960400001)(64756008)(33656002)(82950400001)(316002)(8990500004)(110136005)(52536014)(71200400001)(10290500003)(5660300002)(86362001)(8936002)(8676002)(55016002)(9686003)(26005)(186003)(6506007)(33440700001)(921003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: mpKWMRLsoGHSTaAf1xeCmkKk/3jIsvd66jAU+4zThwFamZZ95jZywUXH+gTJJiVn/8oQVAnhXlg2IJBntpzBfzA6XfWBBKnUwd2jgFObCBSURb7SHsmfd7Ehv85spZy4GqiWGuNyW9tDG3BpW07v8IIBuJm5wKgOVwZ9039nzsASoLl5eVLOsCAFJxFrL7neJtDRlt23JXCAyY9CVA0HfIUqkzH/qhUx0Bkrbd7rFMONoGmuaGFWqV3Dqq4wTMt37whiV44x1EsgbfRqXQKfSvAyTs2E+ElTJRXOSr1CGWlu2Bswni4eWOd6R9JbbatyFH5djCJawLftDvLHZddq3+6saGhKPHIf7/3+a3uK7pSrWkgIiLe/UnEbXeZNlipBPI2v8nofw6SmmJ71IV568egNvSK8CSJvd8y8nzv1/yFd/8OIrAWfncQ3FwyEjZr3mzfCJCFrVakwU0JcOjk+sLFy+xlMX1c7WYMfbBWLxNVLd0kn2J1tVSpaQE9P6lhvaZBGn13Uc9prYfYSPm04q3N1mujsLtQWC0JwY0ski+wrkT3LEb1oHCaDTShKhVj0acqYI2xRj7HtR0BpovugNilz4POoxcG84sVG+u3S7mloCi4UXHfT6xDSm+iLwABaSoy7agep4Ds5CQ5PmWnqulYYMUXNMmXqYrDTv+ZYTvUsIvb65/rEl2tyKOEZ2nBIFfAkk/ukDTW9mb1uQ3MZ6HtM7QTBocWS5nBLedTyepMm3KWPP1nGMwlRWoddtTuL2hb5lrO7Ot7nSrFk+zvocubAuYutIflbCh0/+J7JSeY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ba272c-f228-41a1-6b99-08d7f084dca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2020 23:42:52.1256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BTkX/npZjPeLaL9gt7vGB4C5Xb9tR0fZeY2qvNmkw0ma+55lLhIPCeTMXlnPbAfgtMohVgwUiyu0Ei8qCIVwZrfgFyIOTZ5dz9zg9H3HsAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1004
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Hu <weh@microsoft.com> Sent: Thursday, April 30, 2020 10:36 PM
>=20
> Some error cases in hv_pci_probe() were not handled. Fix these error
> paths to release the resourses and clean up the state properly.
>=20
> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---
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

