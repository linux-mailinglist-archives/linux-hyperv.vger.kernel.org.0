Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CD12B39DC
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Nov 2020 23:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgKOWZq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 15 Nov 2020 17:25:46 -0500
Received: from mail-bn8nam11on2099.outbound.protection.outlook.com ([40.107.236.99]:36576
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727944AbgKOWZq (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 15 Nov 2020 17:25:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sek5+Wqnp204I3D5vZxpLQ4bb0yX3ylZ7YAgUo/TeUrI6kvJf04/4CSUVpUQEjN7R4gsBQ39+Daq0sUCBIcKPNWy+wuztI8G9zaCmuj7KZt7a0AgSSUp4avOZWWmL1JqOjKhaG6CeVN1Ony5OwWgLqB67zEX9HamjLD4eWkMrNPL5cIkeFeYGXiFBalbzBRZTc+0qkmTKNYIPWbYq/lVWjAiG+jq9zM4CMyT3CRGt8tdIS+H7u6pxLivIS1MupRf5oXeqRM8fWxLIZ/DxdBzuaOp7r78TCbGCBdLqy4EPCqlqczei/HdU5CY+ingFmyR5yGxkUCxeZ5ZWUF4P6vt3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnjKMmhAMmTSHUosDv+bRhzijJ3l1JknxNkgfJaTzKc=;
 b=LIEt1vdyAYb9MRzin4BvHKAIQkmhdLmJTZzxsfiAlqjSXM2Wb7baX2/C2+SCyy3LkqU3i1rbYRWX8Yy6ecEsrnsij7rHUvy+smtObmhGlvKgE8ayjiTGXFDzhB91uC8pAxQQUo1CiB++sgSC0NNDsGna24qiQlvzDkBF/9sPqOTJ6IwMLI9/qS2sACEVojzUl0WLbVpQiSSc7iq+BJEP0jYdSgj0S+KVeqoT7lCXwTPEXVmjX5zKNVBLSwoNQ0JVK3b3xUTCpbOucx8ebMxvuI6+O/JVuKFVvAAiMF2AaaDdSgTSV8xpHNifPpxeIFywlFv6Ub7yR1t4jKDc7i+Exw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnjKMmhAMmTSHUosDv+bRhzijJ3l1JknxNkgfJaTzKc=;
 b=DJzWWJAP9u/jLFaXeUDMe6FRkzQbtsG2F+7jPiiFydz7qfPsJErRt/GSTrzEhRbHDm/WsCXsQrMoluQV48Xl85tzkf+NtMQ+7104aIsomXfPU6aP9qzX16Afj4SSO+CSoXBDn7ZncgaqYGCW2ZBIAoS9WONQMxoGZEOuDHCWEu0=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1049.namprd21.prod.outlook.com (2603:10b6:302:a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.4; Sun, 15 Nov
 2020 22:25:38 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922%9]) with mapi id 15.20.3564.021; Sun, 15 Nov 2020
 22:25:37 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Matheus Castello <matheus@castello.eng.br>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
CC:     "sashal@kernel.org" <sashal@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/6] drivers: hv: vmbus: Fix checkpatch SPLIT_STRING
Thread-Topic: [PATCH 4/6] drivers: hv: vmbus: Fix checkpatch SPLIT_STRING
Thread-Index: AQHWu4m02H3gu/UJQUqYA2qrmrFMFanJw6GA
Date:   Sun, 15 Nov 2020 22:25:37 +0000
Message-ID: <MW2PR2101MB1052B329DFC5D54F4D7501E9D7E40@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201115195734.8338-1-matheus@castello.eng.br>
 <20201115195734.8338-5-matheus@castello.eng.br>
In-Reply-To: <20201115195734.8338-5-matheus@castello.eng.br>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-11-15T22:25:35Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d6ac0950-a302-47d4-a6e6-983c9244fc02;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: castello.eng.br; dkim=none (message not signed)
 header.d=none;castello.eng.br; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48dfb258-b259-4891-601d-08d889b560ce
x-ms-traffictypediagnostic: MW2PR2101MB1049:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1049470D4659AB74F09073E6D7E40@MW2PR2101MB1049.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UrOQny8dgRkMSNfchyCaBBOPfDG9QWvHXj6/mOU9qS1rddCtqujeJeJv3XSav7NqE8oxi1U9NcxWoNUh7yT6xao8vRB9fzIUva2suAFCNVW4f9DqRGwP5SZOjS94OEMOchIBbPt2fKYtjh8N6QZw7L3pGqNh7yfUMLZMhGgZ1RiyS0OSnuzAjDjCPh9sxQqGqZ7QgT9oD4NCP584Gp0e01J2mM8j5/TGfH0LrsouuHLtcdnMA/q4gNGdwvenRfDaBG/4v/MbBnMX5ZOiJrxwvu5pylsKoAwhgEoDimei04iBtGqyr/labOHVFP7mupnqc2eD965XxtmWYGQs4m/5iA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(186003)(316002)(54906003)(86362001)(7696005)(110136005)(8676002)(2906002)(76116006)(26005)(82960400001)(8990500004)(8936002)(9686003)(82950400001)(55016002)(6506007)(83380400001)(66476007)(5660300002)(66556008)(71200400001)(33656002)(4326008)(52536014)(10290500003)(66446008)(478600001)(64756008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 7eKX32cVX4EzvOjKVAyA4KmF/ekp5MEsojD6AS5bnIDeofbvirM3QLWek98bmQX2ddKgPzZS+cQfrgyKNTvWPKmcda32J6hhlWzB2pFbjAvS5DcXbhql0g/Jp+qB1NehPVzF7KF/S0cNEe1lirRsfvR/XItAUZ5i5rsEvc3biY45BzUsPEe3eVfoZFSQDXt31KacD9JWaK9HV2MMDkTXW1xKY3VizQria1BVLJOTl3DeZAIatDcJO72bKSN2IaPsj9F8YztFXlF+O82Rb9oEYiezs9a1HnmX+vjMfh1fXPRwiZoHZ50bbSZBy1EGxD9dn4kZQoJ2sNfz4PObGh0d4GlNezBleJTidSeXhF8ISevAeQ92AJrK4BVn9Z0Xwk0CIvaZNm2okypKROjVoFua/UAFxZ7pF5pMNWb/vCJ7QoeAjzHCHeuj08IGzvb/s7Lxnt+T9k5VQsbgKwZJGItWGLUwJ/Rhtj82n1+/PtuaDwfa4p3e7+h59Pysk6OEq8IA9nWkx0y6NFC9MKRyRMNqRHOTmLLzYr19KA5JbWEruz4hl1eQYe8w2fkPdCseODWiyPVZALE4nh2jYAQc9n5yBfTKsPoU8PgW+/mQQiqeDlhB4sGbR08CMwjgZrYQ5josRN3CT9rVHBDUv+aCJ9UWiRTEkJlOaVf9zoOglwIxtoynW90Kg+T6VWo0FAa/HEM+ZdZCpnAi6zbsHxR4huYP/oNnEFTrcftlNh/sXi86c6WhXJKHqBRyLKp4l28LnieYX6RZhSUx48SqK3sEWvu1BdtsbxLQuGdDX7uD+20YsqxYUiQ6ATec0+qjfgggD3v4oV/PPTwENd6eHMvwN3s94UjLnvTX6PqKv5gmc45UGMf1M4lqqgdEA2Wh6b45p+lzqgW/bUa+aIfQFYXyKIzfgw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48dfb258-b259-4891-601d-08d889b560ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2020 22:25:37.7409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abaRn+br4QFghURGnvJqT8uZ3JftwydEs/awn934vB+mslpNID1M5xsQNW1mmB0ep+/azN+fK+63UgC2TyJwgubUnv9WdEKmOUfP8kBmUUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1049
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Matheus Castello <matheus@castello.eng.br> Sent: Sunday, November 15,=
 2020 11:58 AM
>=20
> Checkpatch emits WARNING: quoted string split across lines.
> To keep the code clean and with the 80 column length indentation the
> check and registration code for kmsg_dump_register has been transferred
> to a new function hv_kmsg_dump_register.
>=20
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  drivers/hv/vmbus_drv.c | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 61d28c743263..09d8236a51cf 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1387,6 +1387,23 @@ static struct kmsg_dumper hv_kmsg_dumper =3D {
>  	.dump =3D hv_kmsg_dump,
>  };
>=20
> +static void hv_kmsg_dump_register(void)
> +{
> +	int ret;
> +
> +	hv_panic_page =3D (void *)hv_alloc_hyperv_zeroed_page();
> +	if (hv_panic_page) {
> +		ret =3D kmsg_dump_register(&hv_kmsg_dumper);
> +		if (ret) {
> +			pr_err("Hyper-V: kmsg dump register error 0x%x\n", ret);
> +			hv_free_hyperv_page((unsigned long)hv_panic_page);
> +			hv_panic_page =3D NULL;
> +		}
> +	} else {
> +		pr_err("Hyper-V: panic message page memory allocation failed");
> +	}
> +}
> +

The above would be marginally better if organized as follows so that the
main execution path isn't in an "if" clause.  Also reduces indentation.

	hv_panic_page =3D (void *)hv_alloc_hyperv_zeroed_page();
	if (!hv_panic_page) {
		pr_err("Hyper-V: panic message page memory allocation failed");
		return;
	}
	ret =3D kmsg_dump_register(&hv_kmsg_dumper);
	if (ret) {
		pr_err("Hyper-V: kmsg dump register error 0x%x\n", ret);
		hv_free_hyperv_page((unsigned long)hv_panic_page);
		hv_panic_page =3D NULL;
	}


>  static struct ctl_table_header *hv_ctl_table_hdr;
>=20
>  /*
> @@ -1477,21 +1494,8 @@ static int vmbus_bus_init(void)
>  		 * capability is supported by the hypervisor.
>  		 */
>  		hv_get_crash_ctl(hyperv_crash_ctl);
> -		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG) {
> -			hv_panic_page =3D (void *)hv_alloc_hyperv_zeroed_page();
> -			if (hv_panic_page) {
> -				ret =3D kmsg_dump_register(&hv_kmsg_dumper);
> -				if (ret) {
> -					pr_err("Hyper-V: kmsg dump register "
> -						"error 0x%x\n", ret);
> -					hv_free_hyperv_page(
> -					    (unsigned long)hv_panic_page);
> -					hv_panic_page =3D NULL;
> -				}
> -			} else
> -				pr_err("Hyper-V: panic message page memory "
> -					"allocation failed");
> -		}
> +		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
> +			hv_kmsg_dump_register();
>=20
>  		register_die_notifier(&hyperv_die_block);
>  	}
> --
> 2.28.0

