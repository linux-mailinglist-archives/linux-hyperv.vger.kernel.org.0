Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B325D18A9E4
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2020 01:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgCSAiM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 Mar 2020 20:38:12 -0400
Received: from mail-bn8nam12on2122.outbound.protection.outlook.com ([40.107.237.122]:22656
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbgCSAiL (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 Mar 2020 20:38:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIXXZK4AwHZ4uRcBh34xTE9xS7ZmmGbOI/2TxZHrNYvO37ynNYxBsyK5mGhRtMy+X31PQ7X2PZd13LL3xtwjTUKK90ZfKsVYlMiqu9byxpdzLUYO68Mz+IsIwBc4XCUSHFw8Q/rUqGmyDNHe/aJKJyKVo+QjcaHeLUC40CGbCJMwjPl6nE2fQAPb6L+EN0l3XuO4ODMdWxhMNMXdPS6v1OzqEKwUp2t5UsdIZBr1vIEV3WX3FAoxt5QSLkFCn0uASTQaN41x9qNmRmVAjoAvBHhUs7gJJeTngpe2UMddoACro7lbsLkAOv2AQL8vDmPTwXUHBIgRhSk/HiC6UuQ4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4feH0XEoLGPJJPyok2wjZnLy5XTkCOT1Wdb7ATfEp5g=;
 b=SDWeK9TMUesYTjt/rx4Peknh2UldSoJJYvyk6kf8SbImnXNKMFwGcyQR7C/Ku4AV5kNjaUL8TsLbEwjFPBz5y2AMT1tmhaDP7B3ThNRVZ04D4KlzEfFMIMo6ILnAJUEIGV+xbEsLf1K3v2W1MFap4CpcDMnQKbYWSn+j75+pCuUvlMSNt+ZSisMvgmJhyIwjOJlmHVXzFGM+lyao7rGltBjVRACMDUK6YXoSc0xTXNk1G6R4alrv/QDJ1JaPCCBgVhuAf7w+mntZIf5T3duLnjOn+5fOU/2ktOK3X9v5C/KRjb0kT55iRKf3O9Ur/pMYLo7wHKIM9EadvG8yUGuciQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4feH0XEoLGPJJPyok2wjZnLy5XTkCOT1Wdb7ATfEp5g=;
 b=c7eEWwMnlpPOmnFjw+uqrdCg+C68Iqo1M+3j046iSkEUj8XMPDTBZ4iZZanEl9/HdPwZHejScmvscxMCu8t3F9yocvh4+IVwoSV1Dgsj/B9EE/VvKcOYhGRuV7Usu6J/0HTupncXM13uiyTCpd/IOLKoHirBjtMUWvkFwqN05Fk=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0891.namprd21.prod.outlook.com (2603:10b6:302:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.8; Thu, 19 Mar
 2020 00:38:07 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%9]) with mapi id 15.20.2835.003; Thu, 19 Mar 2020
 00:38:07 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "ltykernel@gmail.com" <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH 2/4] x86/Hyper-V: Free hv_panic_page when fail to register
 kmsg dump
Thread-Topic: [PATCH 2/4] x86/Hyper-V: Free hv_panic_page when fail to
 register kmsg dump
Thread-Index: AQHV/F+KwFvVZiqNDUGYYVaANTfMEKhPE6RA
Date:   Thu, 19 Mar 2020 00:38:07 +0000
Message-ID: <MW2PR2101MB105297BB206C91C1CBF1477DD7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200317132523.1508-1-Tianyu.Lan@microsoft.com>
 <20200317132523.1508-3-Tianyu.Lan@microsoft.com>
In-Reply-To: <20200317132523.1508-3-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-19T00:38:04.8384421Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4b402ae7-a782-4d46-a74b-ab472edb2b86;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c9b3cb3c-1fde-4f09-4331-08d7cb9dcb0e
x-ms-traffictypediagnostic: MW2PR2101MB0891:|MW2PR2101MB0891:|MW2PR2101MB0891:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB089153063AE75CDA642A1258D7F40@MW2PR2101MB0891.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:78;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(199004)(66446008)(52536014)(64756008)(8990500004)(66556008)(66946007)(5660300002)(66476007)(76116006)(26005)(186003)(9686003)(4326008)(55016002)(71200400001)(110136005)(8936002)(7696005)(316002)(2906002)(86362001)(33656002)(6506007)(54906003)(10290500003)(8676002)(81156014)(478600001)(81166006)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0891;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pNCzLQXp0zHrYSqDIxOYsXowmgmx752RwDknbBhV6XtpwSkOSQVdKI9rFNIRjyDWbxm2gNiHN0C506lempUf1DgzANU6oTbigDFRn8RGn1AIHFpkzAsEXU+C6TySaFCe2ENamyv8xFfbGU2Fq+qgkYlH1d+zvH/q02Pm0A03gYQSdWWr9H1L3dSUvRHYGHUUC/jJHNqANzYA+t3sIgw+3DQX0rA+D0g5mV/tMuUkMFwxm2Qr8cWcjNvTZyFp7ZP32sRxAnICbWqs1NArDc0vDMN2bNiD8aRVpOdI8jbhsN9IJlsEvPw+4t78URoMF5ekvYcvxQV8Wz54XZqXfcaeOAW6fvAubcbbY97cljbRy3xZdZHHe8wqCZHLDdrpm81cQRy3QE4L9V36e9kk8EuWX9UO6JvNsKJalJap9gjayDpbwQ8IO4SyNQy+ucj4G91M1dlymyVBgHYBmrfrdCBtJRpsFlPwEX90Z/krsvPcYVdfQ96FVNL9Fo7WKImj2pzf
x-ms-exchange-antispam-messagedata: Ve27rDqAN+5xSRPVUJ/gyn3arVXX12fTL3qOOiSopASqbNn8A4mS2wBtKto57kMXDEKz+Dy+Epe4VTo5K3JfQmLd6QKbYN+lTQCbIVdbMODVfpIuP09yX9vtjMRWH318bjewDhLvhRbmmYosa6LrOA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b3cb3c-1fde-4f09-4331-08d7cb9dcb0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 00:38:07.1499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pSQYreDow8ve8M69/jhZozWYCBjJ9CdL4KFHPFgrsPebgBq6XRJYNdN5AxVLxbzoG/l8l/NcXeEaVQ30sjPIbSLqoNyD0KDgk2LjgWqR1Zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0891
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: ltykernel@gmail.com <ltykernel@gmail.com> Sent: Tuesday, March 17, 20=
20 6:25 AM
>=20
> If fail to register kmsg dump on Hyper-V platform, hv_panic_page
> will not be used anywhere. So free and reset it.

Slight commit message wording cleanup:

If kmsg_dump_register() fails, hv_panic_page will not be used
anywhere.  So free and reset it.

>=20
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index b56b9fb9bd90..b043efea092a 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1385,9 +1385,13 @@ static int vmbus_bus_init(void)
>  			hv_panic_page =3D (void *)hv_alloc_hyperv_zeroed_page();
>  			if (hv_panic_page) {
>  				ret =3D kmsg_dump_register(&hv_kmsg_dumper);
> -				if (ret)
> +				if (ret) {
>  					pr_err("Hyper-V: kmsg dump register "
>  						"error 0x%x\n", ret);
> +					hv_free_hyperv_page(
> +					    (unsigned long)hv_panic_page);
> +					hv_panic_page =3D NULL;
> +				}
>  			} else
>  				pr_err("Hyper-V: panic message page memory "
>  					"allocation failed");
> --
> 2.14.5

