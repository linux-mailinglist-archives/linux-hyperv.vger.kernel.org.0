Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1F11C4A8A
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 May 2020 01:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgEDXqC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 4 May 2020 19:46:02 -0400
Received: from mail-eopbgr680095.outbound.protection.outlook.com ([40.107.68.95]:43233
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726911AbgEDXqC (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 4 May 2020 19:46:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJhaJNCG+pqCwQ6zvOHeVbHSRLZetyqyhudrpeSXDoGonDPbDO8/jata5mVEC/rQ0ly8Kj4N9+upiqqSym50XWTwFAm7wYtO0/VOr4h8QU5CB6dQgfxAF1u2+0uLOC8cnnn63E15f1MvFIasOINmvCdqURv17sqVfV0XmzmEEJPmVIZmrWB04ti+KH0F6sMHWE+F+MZep7i9+VeRLGOfIeqJqHN7jyTBJ6e0ql6juSU1Jb8BSHXIPUKInEmHDsjZoCqf7wz9jcHMRMeoAVB0G4PhtVFC7aUxgPA1Hc6YbBV4qu09f1WgEOSJOiTHAI117TNwNRU4xaXLh2/tldDJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQmK+ef+1X94VfsZ+h9BKEa7gGhq1O26F3E+VApMdPc=;
 b=GtWVEmSzScG1N+PwbMF6unRumJ3MrGb5YmNQhq5bf04L5i6YbxREusPj0oDztgxPxpuEae/ivZ8bJFTSys3w7BzGnbqUoJPMI+1/rrM97dsNN9S/JVrggXegBwQL4godgSjBZPKKN2rjKRXL4bEEm/BQLTSJ37kT0WqXapAtznC5gCSnM2z4acCkWkU7mRQDR6U9tMGlpYWnIlTpZcFeusn/YGEcGNd9acOb823fTncqvGsClAd9ALFJHLUfzopQL8e+BNC+YVhhy78pGMyeJ29xEk+q67VlDoNegr7Vf9ZgmMsoybBOpYU4Wj7QAPZ4Vu9ACwb3qjmjk4EhJ/oLuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQmK+ef+1X94VfsZ+h9BKEa7gGhq1O26F3E+VApMdPc=;
 b=habj8ApkhrVzLUg0JzNWicQYBMurDHzZN84OWTtSClPbpQTGozh5RpKt1ZWVrkMOR0vdMt1Xjx30WLoA37X8wqF1BfLgZIBqioa0D44kn6y7z/4rKvC1dsuh58QZNA+USUjcpVw7CQOLt9byyEopYdV63E8vA8CZJYifQ7bQmDY=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1004.namprd21.prod.outlook.com (2603:10b6:302:4::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.3; Mon, 4 May
 2020 23:45:58 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::5a3:a5e0:1e3c:e950]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::5a3:a5e0:1e3c:e950%5]) with mapi id 15.20.3000.007; Mon, 4 May 2020
 23:45:58 +0000
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
Subject: RE: [PATCH v2 2/2] PCI: hv: Retry PCI bus D0 entry when the first
 attempt failed with invalid device state
Thread-Topic: [PATCH v2 2/2] PCI: hv: Retry PCI bus D0 entry when the first
 attempt failed with invalid device state
Thread-Index: AQHWH3qvuWQEJfJorUimFOkwHbGJ56iYnRHw
Date:   Mon, 4 May 2020 23:45:58 +0000
Message-ID: <MW2PR2101MB1052F3C838E8E49823FCF47DD7A60@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200501053728.24740-1-weh@microsoft.com>
In-Reply-To: <20200501053728.24740-1-weh@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-05-04T23:45:56.4959192Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4603fe58-4f86-489c-a9e2-57748da1ea0d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0d28e944-7909-4bd3-edf2-08d7f0854b8b
x-ms-traffictypediagnostic: MW2PR2101MB1004:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB100479E44AF677DE2627C8FCD7A60@MW2PR2101MB1004.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03932714EB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QQ5by2qwt3mXv9Z6CGikyAIy/ZQzOWaqYZzUSqS5j3jcCFrItgyEx14OAXkdcWub6ZOBWD2vhgwdgcOtz63XOWRuaREVy4UpjPELKNLWWdvuWJNAm20vaT5N0dWvj60fLT2HbHklRFTALkfg1L+wqSI/4ZVIc4tRDjEBQKY21y4x/dFSClx1SAbXj20JnfSI5+0yVcwAMHJuVZ81JqCtQ9Xm9249w7bg4psswWDPMzVTOeZAe/W5joVVAe7jqStqPADyQ5zvOrMfy/2juUPN4gyWO9+yw1NOO1dAOgBUN7Nm4xc+FQV9XMg8hy5cCX38frOnCfJ62ei5ZzN3cptZfxwIeNlgKEpaSaAO7sBAA6aItHSgUVFQYx7Supc2/0bgss+iD2sM1kaQhH+uFE49+xdReOV8cMlzMtq4DQiVXekRjGjWesgCVhzescCGxrs//UgO+ABKGL2KMzvRITpkGFYxSlGdNvJ27r+7woOdqHuGVAoFs6fmm9j9ZAjbvSjwsMSLg/nL3LI8R0R9DcJW2N+Y5X8Lh3WvJe6jexqj3BM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(33430700001)(76116006)(7696005)(66946007)(478600001)(6636002)(2906002)(66446008)(66556008)(66476007)(82960400001)(64756008)(33656002)(82950400001)(316002)(8990500004)(110136005)(52536014)(71200400001)(10290500003)(5660300002)(86362001)(8936002)(8676002)(55016002)(9686003)(26005)(186003)(6506007)(33440700001)(921003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: zzR91oMwzCH1wDvP9cKxyBffT+PmoGd10ErD7szmWoRNvMuciYycbDFv8rw6P+upptNu8ZWbJvGV1ReQN2q5dETpJyP0SifysgQUn+FUSVTdsPfQsQD6MGUb8zHZUesBdLex2M65ELoNL3FgiCqfNnxNTz35ws89KKNxDO+INQf1biL6512Lh9czCaR/lGF2Y67DgNPjU08uprKGOj+9ksNe36LChz6Jy/x99QeYTbGB7VwucHbDYGq9zbxxR18U68dd3CvJ89sewW/eyl3lcbK9jYB55A0ZuMsBGscI7v0vR6loxrL444IElzC0NF4SZXFWjBBgOec0YT5KiaER6C3GLeggUVBjhmcULEbbMXqEyB2Jum4aDHv6Op7Te57oRa/J8lnb6TSw6dUpuXXrJlvv4n9m2FzADRsWvQcDxHbAO6hieM9mdRERGznGFraE4+roZfCancWOy7YFx62J05P9S88MRH/ilxd9ypfTSGAnIGxIf4SoHRme946whGkpMOt7S+wWj7JRckN9gXjj8uhRECrd0x4giWz8erk368fJak+00/jABYyGqX2QMeSxU9Ji15yGJzWhiGY59Szk+J0cBKrGbMog4P4KlhcN+CmUI2Zw5/fiYqaN78tgAHSwkqxiKco3IwGOxwxGJvnx5pv8c1e1sZ3hqkTKldKuTzpLu4PY916D6IRYs0EfQzKYqFAAGBFdJTK7rBgXL5ZCvMP5fbeEf52IhOHxO4EK0Gi8yQk+6KHJFoVF8E68BSPDnLI/n0J/engyY8sNumK98sxI4eTvm+koN3rvfHHrgc8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d28e944-7909-4bd3-edf2-08d7f0854b8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2020 23:45:58.2384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mgyVfh82+134RN+iAL6ARo+4H6+MIAHDls85dZseab0pzOVJxPFAtZHjAA8F23h106O9sheMtSEA2cfDvKgdQmVw0sfVVDfbUfJtNC5YuXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1004
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Hu <weh@microsoft.com> Sent: Thursday, April 30, 2020 10:37 PM
>=20
> In the case of kdump, the PCI device was not cleanly shut down
> before the kdump kernel starts. This causes the initial
> attempt of entering D0 state in the kdump kernel to fail with
> invalid device state returned from Hyper-V host.
> When this happens, explicitly call PCI bus exit and retry to
> enter the D0 state.
>=20
> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---
>    v2: Incorporate review comments from Michael Kelley, Dexuan Cui and
>    Bjorn Helgaas
>=20
>  drivers/pci/controller/pci-hyperv.c | 40 +++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index e6fac0187722..92092a47d3af 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2739,6 +2739,8 @@ static void hv_free_config_window(struct hv_pcibus_=
device
> *hbus)
>  	vmbus_free_mmio(hbus->mem_config->start, PCI_CONFIG_MMIO_LENGTH);
>  }
>=20
> +static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs);
> +
>  /**
>   * hv_pci_enter_d0() - Bring the "bus" into the D0 power state
>   * @hdev:	VMBus's tracking struct for this root PCI bus
> @@ -2751,8 +2753,10 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
>  	struct pci_bus_d0_entry *d0_entry;
>  	struct hv_pci_compl comp_pkt;
>  	struct pci_packet *pkt;
> +	bool retry =3D true;
>  	int ret;
>=20
> +enter_d0_retry:
>  	/*
>  	 * Tell the host that the bus is ready to use, and moved into the
>  	 * powered-on state.  This includes telling the host which region
> @@ -2779,6 +2783,38 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
>  	if (ret)
>  		goto exit;
>=20
> +	/*
> +	 * In certain case (Kdump) the pci device of interest was
> +	 * not cleanly shut down and resource is still held on host
> +	 * side, the host could return invalid device status.
> +	 * We need to explicitly request host to release the resource
> +	 * and try to enter D0 again.
> +	 */
> +	if (comp_pkt.completion_status < 0 && retry) {
> +		retry =3D false;
> +
> +		dev_err(&hdev->device, "Retrying D0 Entry\n");
> +
> +		/*
> +		 * Hv_pci_bus_exit() calls hv_send_resource_released()
> +		 * to free up resources of its child devices.
> +		 * In the kdump kernel we need to set the
> +		 * wslot_res_allocated to 255 so it scans all child
> +		 * devices to release resources allocated in the
> +		 * normal kernel before panic happened.
> +		 */
> +		hbus->wslot_res_allocated =3D 255;
> +
> +		ret =3D hv_pci_bus_exit(hdev, true);
> +
> +		if (ret =3D=3D 0) {
> +			kfree(pkt);
> +			goto enter_d0_retry;
> +		}
> +		dev_err(&hdev->device,
> +			"Retrying D0 failed with ret %d\n", ret);
> +	}
> +
>  	if (comp_pkt.completion_status < 0) {
>  		dev_err(&hdev->device,
>  			"PCI Pass-through VSP failed D0 Entry with status %x\n",
> @@ -3185,7 +3221,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	return ret;
>  }
>=20
> -static int hv_pci_bus_exit(struct hv_device *hdev, bool hibernating)
> +static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
>  {
>  	struct hv_pcibus_device *hbus =3D hv_get_drvdata(hdev);
>  	struct {
> @@ -3203,7 +3239,7 @@ static int hv_pci_bus_exit(struct hv_device *hdev, =
bool
> hibernating)
>  	if (hdev->channel->rescind)
>  		return 0;
>=20
> -	if (!hibernating) {
> +	if (!keep_devs) {
>  		/* Delete any children which might still exist. */
>  		dr =3D kzalloc(sizeof(*dr), GFP_KERNEL);
>  		if (dr && hv_pci_start_relations_work(hbus, dr))
> --
> 2.20.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

