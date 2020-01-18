Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19B59141886
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Jan 2020 17:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgARQva (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 18 Jan 2020 11:51:30 -0500
Received: from mail-bn8nam11on2102.outbound.protection.outlook.com ([40.107.236.102]:12257
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbgARQva (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 18 Jan 2020 11:51:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/4AjXso95ahFT1dAJgFbRDZoZ4GFaFY5wzB153vFEsi37bwfM/DzbXnDn0kjffDvPJznS54UwzeTHjoSmFuXQKiNbAZfN3b+L8Q8I7Pfebv43BcSlWbIxdi4WV3KCgL1Y02iA2dvhYFmJhrvazkjozW0e+GOQrogcd0dOl59oBTAGOCVwSRvRxDY6xabeXbl2eLq7riiEeq3EXZkqnwLxwURnateh7RmRR83ovjzpcV6LpaMNXTJOoYJ2ZQA/SBQeAUR3PHDBsdca+rMf1T8I1pAhySKoXhnxxG+pnm1m3ewIXMQZeNCfUH3ZZXKHWBfV8RjNHlze5DEVW+l1dijA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2HFcMYlQhyWZISisF/dn3FVQ9aw9KjGDw13OE1vcdk=;
 b=LSJXn0O6oVsIB7LcJH9EmB5eVQeftCfXfL0KRJTVyuJ18QSRwPuwNQ4rDdZXeuLtnfsG8Ndty0Fe7j4XDKlEML0/ezlvp/HszsqOulKI4p3kD9rSBUS7NMrKmwfTTBzHRS/3Dp17tqyF5Th/5eO40iGfkjLEiGSKWc6fVr6BNY3F79WkV4ajjMBxvwnjuka4YMWcG9bkeoPvt+fMWa9OWu5AVSGayB7W/8lYvUpcF9Hp2yi2FA8/RGfGOHrOOTLOaNdSytJ5+ExPVaMa8o42dO+E5jC9Ht0lNUXT6uUusxv08JE+xB/Y7B8bxReSHQsFMs+s2GT1BkQ0MMEQBNfd/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2HFcMYlQhyWZISisF/dn3FVQ9aw9KjGDw13OE1vcdk=;
 b=Ccaj6t0v870nJ8vbvHV1tYzNZ8ns6VwxTPhz0j/dZG2RjQkIXsXLviPlKNiwwb4TY4FNkKbjdadHv/7avpX/HC2aBjAdlykKxcocvc2qLMroGLbfIHXmkwn/oEaP1j0C9wWY5apoCUINl+TRoQTpeHYjrCsLQKjTF6zim9u2EUw=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (52.132.149.16) by
 MW2PR2101MB1065.namprd21.prod.outlook.com (52.132.149.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.6; Sat, 18 Jan 2020 16:51:24 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::f1bb:c094:cb30:ba1f]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::f1bb:c094:cb30:ba1f%6]) with mapi id 15.20.2644.015; Sat, 18 Jan 2020
 16:51:24 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: RE: [PATCH] PCI: hv: Use kfree(hbus) in hv_pci_probe()'s error
 handling path
Thread-Topic: [PATCH] PCI: hv: Use kfree(hbus) in hv_pci_probe()'s error
 handling path
Thread-Index: AQHVxOIsTpTzSTXTe0egmmosRzmUC6fwtCBw
Date:   Sat, 18 Jan 2020 16:51:24 +0000
Message-ID: <MW2PR2101MB1052343716F0992958B2EF1BD7300@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1578350351-129783-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1578350351-129783-1-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-18T16:51:22.6364215Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f1df0b67-a398-414f-a564-045017e6311e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ba3393d5-4a76-4f35-7b3c-08d79c36a72a
x-ms-traffictypediagnostic: MW2PR2101MB1065:|MW2PR2101MB1065:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB106537D72F1B5D8B16FD43D1D7300@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0286D7B531
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(199004)(189003)(6506007)(8676002)(81156014)(8990500004)(86362001)(52536014)(81166006)(64756008)(6636002)(76116006)(5660300002)(7696005)(66556008)(316002)(66476007)(26005)(186003)(33656002)(55016002)(66446008)(9686003)(478600001)(8936002)(71200400001)(110136005)(10290500003)(2906002)(66946007)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xn+aRjT79ycs2mwYgbsbElI3hLQMWm+1zxpdMaR1ZtsKzjdL8G5alhi3nH2LKIMrQs496ZxP4nLphDaxhDSshAHjfolXcaypSZz3UlQ1nN87zCCt0B6M/4VTmCozQGPGlZVlA232U6jn0OIFXNVnDFWvl1UHaXs0N9/ItJE8N94bFFAJNhjAktsPuvBO5T5IUWwi6wfLo9E7lKQnCFYhk805naYTAftnxpU3F9wdA7/JVcSv0hi24UWRXMVD39X/227skO9azoKp+q9CYN6PJ/dsZUEXMJWkE28TXmXzegbS/7UpSgR1jvP3jRrUsFR2CFjl7LEpWt7Qi2rHRqnUloIhU5ySlrxyyc3jGYvQg54ZNRRiMWvzfA3WifFHUo91YHkjRyO7MrUH/HkPYky9A2boPsUMJMoFV0A842e4S3IhcwNUQ/GT76SjLc/+afLYu8rKEdxAxc3pMzaa8z9l53Lw9IytKopPJPlcCtMMoBeU+HxwzxTbjvxF4A69UGak
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3393d5-4a76-4f35-7b3c-08d79c36a72a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2020 16:51:24.2111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SThfetogd1rd3L7u1mjC85sLtjVnqigB4mUDPUxyIYwh4LIduSL2vA6ZHrTXD90dL3IuBgaS7AcKQ1m/9XgM0i/Hb0m2tHliiHw31TQNIFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Monday, January 6, 2020 2:39 P=
M
>=20
> Now that we use kzalloc() to allocate the hbus buffer, we should use
> kfree() in the error path as well.
>=20
> Also remove the type casting, since it's unnecessary in C.
>=20
> Fixes: 877b911a5ba0 ("PCI: hv: Avoid a kmemleak false positive caused by =
the hbus buffer")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> Sorry for missing the error handling path.
>=20
>  drivers/pci/controller/pci-hyperv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 9977abff92fc..15011a349520 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2922,7 +2922,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	 * positive by using kmemleak_alloc() and kmemleak_free() to ask
>  	 * kmemleak to track and scan the hbus buffer.
>  	 */
> -	hbus =3D (struct hv_pcibus_device *)kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNE=
L);
> +	hbus =3D kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
>  	if (!hbus)
>  		return -ENOMEM;
>  	hbus->state =3D hv_pcibus_init;
> @@ -3058,7 +3058,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  free_dom:
>  	hv_put_dom_num(hbus->sysdata.domain);
>  free_bus:
> -	free_page((unsigned long)hbus);
> +	kfree(hbus);
>  	return ret;
>  }
>=20
> --
> 2.19.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

