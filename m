Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB17070A947
	for <lists+linux-hyperv@lfdr.de>; Sat, 20 May 2023 18:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjETQuT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 20 May 2023 12:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjETQuS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 20 May 2023 12:50:18 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021025.outbound.protection.outlook.com [52.101.62.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFDDE9;
        Sat, 20 May 2023 09:50:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDHDFd7ef5PF2wyXnoipFijmtsnRMOtpgKYJND272HNw3vq1ctZHaVzc3FRltPk7IXJpygr8jgMU0B2iw93B/78XM93xUHtSEo0p328FjX1BdBAG+8auiiXKbDI6y9AP+UncuUg2Hm0Nn7X8qKuXRk0ZW3vGTxaWl53QEQ+84M4kk7ztkq3YbePJtai6AoDfnARsT4aZTdJTtcSa3yhjexOcuMJZZHaYGt1JJOVpHJefKbOGjy/i3O8lzs+NuuYBiXxEI8IpXgY7d71lW9WuGIDrdDidW9Rgznbj8qcFOapnPPd5rL2J4eyRJDhJcUcfQW0jkzFySyXxthoX3++dwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nk0UmCgHLKyKXa++q0JQFeNiFBT+4gy/Zuvgh/xKXpc=;
 b=CrZ5nagMDs50o619/14SGqFf9tUmifgUUKm5pAdgtoOQz/KXcArKk1bWRg6uZlOoQJ9SF49KRfkFmFNAjy4832vOcNIfzFz8fWnDh8UZ1a1xC9QU2FE9yaMGzTniLPuQRwTcDgy5sAJ9Dh6hh1SrIyRDwwKnKZ8Zp2Gg6r/nl8zKN/dFlRwR/O82jJQbO7Mhhl71n9a1YNisU1+q31ileSyYxNxmBWmF811QYkyWxg2perR/xBhGFZT3S4EUc4XRE8J373V9cMu5HKjFpzHSfHvFgJ7BSUNHlzx8zPwdnYN4D0D5Y4lRLHbpeykNUQ3Vo0DinmaOIYyEVl64+W/F3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nk0UmCgHLKyKXa++q0JQFeNiFBT+4gy/Zuvgh/xKXpc=;
 b=Ba+1fp78OtzW0YtY/kB15D9acvlEt8wlvjtxogMmqGcgh6QqKg+sGlmXBGR1b9sFcOryifTevvoJrzKyl1aKxrqD5mMGO/yAdXVrCzZx+624H3QpgaeuTbtiSlnF69c2Sa7rzXG1SxBq8/d9Ww36g8Nc//JdNIXNxaV+6PEywPU=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SN7PR21MB3955.namprd21.prod.outlook.com (2603:10b6:806:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.12; Sat, 20 May
 2023 16:50:14 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::a4f7:2466:97b5:bd31]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::a4f7:2466:97b5:bd31%5]) with mapi id 15.20.6433.010; Sat, 20 May 2023
 16:50:13 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: RE: [PATCH 2/2] Drivers: hv: Kconfig: Add HYPERV_VTL_MODE
 dependencies
Thread-Topic: [PATCH 2/2] Drivers: hv: Kconfig: Add HYPERV_VTL_MODE
 dependencies
Thread-Index: AQHZhBiSXHyss6LMXEKxhJqATsYYqa9jayRA
Date:   Sat, 20 May 2023 16:50:13 +0000
Message-ID: <BYAPR21MB16884CCC195B1D90BFB30D0CD77DA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1683816877-10747-1-git-send-email-ssengar@linux.microsoft.com>
 <1683816877-10747-2-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1683816877-10747-2-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c4755354-b2f0-4b02-974e-488479445ce0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-20T16:39:37Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SN7PR21MB3955:EE_
x-ms-office365-filtering-correlation-id: 4b04b05a-e7e3-4558-6d51-08db59524855
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VuL8tJUZYcVKKvzSnq6BqaFQUtZlC3qlfySJ2XVKaxWzS8fvQcEIQaTKddqEi7BdoEZldqCt3S1IP+YJxobB29U5G4Lh8xIhTS59ccG/q0WQNB+BXT/DPbUTVWZC8MaozWzsUkxwb+dSGA2RD+G2VnvIAbC3PGdlCBOCX41SzAY1L29mTZ/kpwu/jC/CqsNfUffoGWBiFlq/v2bxAc3q+vX9fQp6GXQH+pK1IDiLBirL4IHKF4MChObBRcrBIA85YDW9iHIv2NnnU73OhDljfasXEvTW3wUikZ+qhEfp5Al4obYXuVLm3TFH9Qss7cuFIWjP1XbsPI/REXBIUvBXn3cx3i4wUdiVaQK1PRJKLSxk+YQHsP+EWop9CQzR7loRWrHJoCQDSaSwvdjvh3VFKyAi0FArHOmhqJcJCbRC0Ap3VGlX0+yBrfoDJhob9SupeGOtHMCLVwtJjS7EYLMa/LVHFFHMUT0tRnvbpeL/XcqHJW70N8NwGjiI8mrUgF2MMXhGJmo7u7dlxbsnhkk4c/w97IgjlWIrvulOOMwfv0r2enFjrM8y8Q0uTWCCxBvj6c6kVGX8wiarSeu0sltx0ZCvmyiVWf8WQiWid2bW7+z8QrDNs2Es5PpTySBhjfHvd+VQUfRKbpLh1nS2LCnwQ94Bg0iYyxSldujdfaXRhWOsnTiy4wBPBhNxZatoCxaD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199021)(55016003)(8990500004)(83380400001)(186003)(2906002)(478600001)(4326008)(66476007)(76116006)(66946007)(66556008)(41300700001)(7696005)(786003)(316002)(64756008)(110136005)(66446008)(71200400001)(10290500003)(52536014)(26005)(5660300002)(9686003)(6506007)(107886003)(8676002)(8936002)(38070700005)(38100700002)(82950400001)(82960400001)(122000001)(921005)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6HTFJydf7jiR8RqBIXy8F043YrVn/86XZwknxQFYZ0MK+sfXOgiDqGH2i7ff?=
 =?us-ascii?Q?NjcPknVV5IprjL2AP2WOScn/1E04OkxbSO1YTAV5QI1ZiHqRUOXEm2vaEI0a?=
 =?us-ascii?Q?WTBCNhkIdBzujt6tFuYBnqD5BxDvbm/TwhfH9mEi499OZA1lt5xl1F25GbO6?=
 =?us-ascii?Q?Y0im6Lu8FlIIgN18nEA5zhthRpX5Az7+L5L4sgRhiMsGPjZL5SXR0s959T0U?=
 =?us-ascii?Q?DmZlt801CGOIfYJVV/oLJjMu7Daa+O3BKQpFFj/TlHf+RfcKxyHLtaMIf7gA?=
 =?us-ascii?Q?0JB0w+J0au6BKzFD7nd4JwgjmsJWc0up4rDdxS09tTlRGdW0/xey2HledpCJ?=
 =?us-ascii?Q?11X/bMHZt2Z2M6Aegl/2O6xWw35KaSEAkV9WX0+Ze6L4mdRKLhSrtUY3a0JY?=
 =?us-ascii?Q?U9AswuIosAk14onhTdqIWZUIScYPSCm0ereALC3Auiz68GVfCqMPB3Y3YMOX?=
 =?us-ascii?Q?q6zBdsaz85YOJae4W2sDvSpqfhewC9NiF/gK8yCPC2r/vM5IRPjL0xK1kGzN?=
 =?us-ascii?Q?TVUNKJY+WT5VV3KSiigiPm4llp/tCtQbd2CLii7iwh1z3IHU713Kbo165Mwi?=
 =?us-ascii?Q?W5whAg2m2/khagAXl30KU6YCIiAOta3gYfABvxGmgI0jA4n+qTuJBN7tucOB?=
 =?us-ascii?Q?lQcpyOqwVVDgPQkV31ppS5h2q/Q+gSQ3tH/r5v99lPCX/BqKNUFI4Bc+bQgr?=
 =?us-ascii?Q?rhfIo2P+F52I1MyPBv6Cy2vOusZti8bXTQmO+6WQnc8XefAP5Mwm5gzkXnPz?=
 =?us-ascii?Q?XkXI2oYLoAJjRqrzp6c+Dazdz5kY2BHg4bbV1F4kzCVJPqbce3a7iC2l7axx?=
 =?us-ascii?Q?F3iehhUsvDjkxpIdI29eVe0ecMEud8WW5TW61Xb6ZXw4wsUXvzL34QaovvYs?=
 =?us-ascii?Q?+fZbGr8AV98pGA5sEbJUpk0iKMdnQHMJ2Mw1Cl0W5sab/XxprhhJO/6GjqeD?=
 =?us-ascii?Q?Ci96+m+Awsw2mE2vLfOg01751dVDlvASFS4gBbOYk9L0KKK+4uMZo6Ya90XR?=
 =?us-ascii?Q?fUCliYOPLSAm4kMH25bYbRwCatpVY1HwfFOeOF1qNLsQ6FAc9Hwyq2LlGtS5?=
 =?us-ascii?Q?qtWhcB6jdQQ+UewciBJ0Y8/A+PGzJ3MsBW2qnH9qgGAQm2dzupmy0AGzVSr2?=
 =?us-ascii?Q?Be4wb4D2br3x07oeWOagF+raKGG4Yq9ZdnXvbJK9HH0U7b9rFEJCI8Ne/d93?=
 =?us-ascii?Q?CT0t+v0vFoVXr/ubBaExzegxO9N0dUUY0ZjnpIq7vcF+6aRXju3aAX4zLFwV?=
 =?us-ascii?Q?sZF5DHlIWPeXSL1Y8lCfEuWUY7pcELFj7xpUMbNnScaoHY5u/5ncxZ7hSULy?=
 =?us-ascii?Q?oVZbkjt22BD8ajE+8cOsvECIDqscq+a2PFGxmxQsADcuNrC4GQS7zRWJwX1+?=
 =?us-ascii?Q?s3e52ftSJoLbsKNTI7tchE7Rk2CU9/OfNypVuZWgYgXgnNdhzg7X4l+ajVAW?=
 =?us-ascii?Q?Ipja+hMpfeXsMXl12qs3nQQ2aRlScrny9G9XsC6u/KzzzWbW6Y8FxvqOEtr+?=
 =?us-ascii?Q?71XO44rROJ4DdJGVoQvxWLVp+3H2kV6KQprOqSgBe8jHAD61dW5CtLLBkOMS?=
 =?us-ascii?Q?WrFtAMfPDRLVwf5QogJzFsxLUXxri2OzlYeQjiy4uLary3ghRWexqbCBwaE3?=
 =?us-ascii?Q?IQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b04b05a-e7e3-4558-6d51-08db59524855
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2023 16:50:13.8327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l5QJI8h9rqUprod9IQTPQ5tGhdPiZeBJrsaUF4MNgPzitVBaisM/UFsaTSZIs82JP2N48OB+Rb/5GsHUh4kV0J+7frxIZllQ+nGS+mK+vz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR21MB3955
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com>
>=20
> MTRRs are not per-VTL and are controlled by VTL0, make sure it
> is disabled for all other VTLs.

Clarifying the wording a bit:

MTRRs are not per-VTL, but are always controlled by VTL0.   Allow
building for VTLs other than VTL0 only when MTRR functionality
is disabled.

>=20
> X86_MPPARSE scans low memory for MP tables, which is not required
> for Hyper-V VTL platforms.

Is the above statement saying that MP tables aren't required, so remove
the code to save space?  Or is there a problem/failure if MP table code
runs and scans low memory?   *Requiring* that it be disabled, and the
reference to scanning low memory makes me think it might be the latter,
in which case I'd suggest this more forceful wording:

The MP table code scans low memory, which causes failures in VTLs
other than VTL0.   Allow building for VTLs other than VTL0 only when
MP table functionality is disabled.

If you can give slightly more detail about "causes failures" (a panic?
some other problem?) that would be good too.

Michael

>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  drivers/hv/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 00242107d62e..c8d443886b9d 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -16,6 +16,8 @@ config HYPERV
>  config HYPERV_VTL_MODE
>  	bool "Enable Linux to boot in VTL context"
>  	depends on X86_64 && HYPERV
> +	depends on !MTRR
> +	depends on !X86_MPPARSE
>  	default n
>  	help
>  	  Virtual Secure Mode (VSM) is a set of hypervisor capabilities and
> --
> 2.34.1

