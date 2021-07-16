Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB4C3CB84C
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jul 2021 15:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240143AbhGPOCf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Jul 2021 10:02:35 -0400
Received: from mail-bn7nam10on2103.outbound.protection.outlook.com ([40.107.92.103]:15584
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240066AbhGPOCb (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Jul 2021 10:02:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpGhFcAELVSOqBTiG6bpJSnYAn9qJGWJ9gfRliJimc+W6nBiEksaiCtTD8tJH3Vh5wwx5bQv8M/veCd+zAETDW6MbTXfaLFggXAzZveg+aoz6A2voKLxFJoa1psuF1DEPI3eGuUlKngIptM1nYFYNsWFQfx1IjbLX7osNp9JytADMcczAgX7xegVXroClA7iZi9K4H0R3dsHi+iGN3CHNA+rTwJduRp0BkIT8/TzHWvO/m7n31uLk/UlytguLN8mms0eGu95/cM58u+kg/qARx/QOWz9Uax1DFhf5ejIqfShY6c9Aba+3lGkv2AEkX9EUvKJja6vWgCypfnO1jzOtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rss+QqLpLzv8NK1KCaDlXMz4IgIPDLV4DvFcX9iHVVE=;
 b=FYiXFXox2/0Du5lNvZjtJWd3v8Xp4JO/PSQt9JfhKw24fdTm3NEQ9cEVO3E0vPEMCdynTi/Np7q5r2j2vozFURg/PdN2mh3CDO9k2SoizPTwMoeptmrlcVbj/L0/NWowCEkG7A8AORWZmHFMREMo1DPv2HAMiwSbFbE4Cl7VCuKm0VRw4MKlw/gy+HoN9SjQcD9xGsiGPCeA4s02U6MasyIlpXb9VpNUFAM8E3g9TkcWY6VSOq52zm7dWybLqIefcAHjtpvUgcptgnLWYA1XUa/yU3GLYrva0gq3GKER916Q4ybwWJkWIvQ9xtZGiz6R+xLIEq3POFiKls407QhlFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rss+QqLpLzv8NK1KCaDlXMz4IgIPDLV4DvFcX9iHVVE=;
 b=TZFPqmmy3qpjUY2WNl87DqyrVQvJ8Gfd+2jYebkV9B05ZgGDHNtcdJtbGD7TBYFsuXrWTXJgLvhGj2Red+OeFAbd3ZVkO2fFc1+RbJcNv1rNH7YHsP6tQ8gjAIgq3ctd0K/cyZ2RiNsvCzkJY4EaRY94IokamIsTT6HpoIFUJB8=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0861.namprd21.prod.outlook.com (2603:10b6:300:77::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.4; Fri, 16 Jul
 2021 13:59:34 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cdf4:efd:7237:3c19]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cdf4:efd:7237:3c19%7]) with mapi id 15.20.4331.021; Fri, 16 Jul 2021
 13:59:33 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Ani Sinha <ani@anisinha.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "anirban.sinha@nokia.com" <anirban.sinha@nokia.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v2] x86/hyperv: add comment describing
 TSC_INVARIANT_CONTROL MSR setting bit 0
Thread-Topic: [PATCH v2] x86/hyperv: add comment describing
 TSC_INVARIANT_CONTROL MSR setting bit 0
Thread-Index: AQHXekcZZUTg0OTygUqBQBhEJHkjCatFoM6g
Date:   Fri, 16 Jul 2021 13:59:33 +0000
Message-ID: <MWHPR21MB1593767AA88C7FD60A476DC2D7119@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210716133245.3272672-1-ani@anisinha.ca>
In-Reply-To: <20210716133245.3272672-1-ani@anisinha.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=344bf3f2-7a83-4c6c-b032-1dc99a311ea0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-16T13:58:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 359f06bf-4df3-42f7-c012-08d94861f0da
x-ms-traffictypediagnostic: MWHPR21MB0861:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB086130C0DA583C29079CCD98D7119@MWHPR21MB0861.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ri5ji7BLKd49NYB1Hll5x65kkhltSnyBdbphDaPBSPzNytI4Rg0ajAQV+4dlrl/ygfvX1BXkeae/XqAo/9reYbJfXOHgGbDBhuHsVSc9hHe4soqH3TVB+sF+I5w9HCSKiESLWqKXNcBOSyYJMEfqZD1WGLWTIgohnv8Z+Rue4eKhW231HcRnlYBd29Cd7eJgeytu9i921B/5jPPMKjFfOkJtIww7tmfrkImYrlf3pM3TDBoA1+v/MQaT140hK6Bi163XtAQNqu9O1aVcD4AJ1Q2SvCWRdLCQ4vxZljvAfQcqxtOFk0Zt+7p75oOteMyZCw/Xm9Qu5e6JF3I+QfEp0IW/6mMAOe3WIjvRCz/dWr011QgbtAVFoSlAVuQrVQI2ZdSHLhBn7ZZifTN9/0+04pRg8SIQSlbjf0czpULH48EOnZvGAYY0t8inDj/x8QnO9vHC7SfqzDTcuuFY7PcfdFBfutMuBV77K22zdHp1E5fAwYr7rd7dNAbbqYbJTSPrD5k5MwOx1M8r7dnP/Gxb4rHpI9kqwoOneZ8wA27fczSzqxE1L8wnSNCEGew4ctGtci6b8KK586jJ9wn7Owq1LhsZJQW+YYwGjXUMjClTUczvoqQbWjM8KOAbti4o+D/seruZaeyI5pa2VFPgXNym9r+wUIKsDvyAh60Z71npxSdGu9n2isqaANwRlBUw8YRRaOMKLkRg6sr1zobVLb571w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(66476007)(7696005)(76116006)(38100700002)(86362001)(186003)(508600001)(110136005)(10290500003)(64756008)(6506007)(83380400001)(316002)(66946007)(8936002)(4326008)(66556008)(54906003)(52536014)(8676002)(66446008)(5660300002)(71200400001)(8990500004)(7416002)(122000001)(9686003)(82950400001)(82960400001)(2906002)(55016002)(33656002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zfgT45J1Nr6/F9xiNggkQQA9+nhqSwUu4uj9s2q5/PEXj8OjZ4F7MunaxDzh?=
 =?us-ascii?Q?x1+MkI3c2l4mdQdxZ55aCKNunCKpPvdvSJWpOqyZfaq6u9vYWByJiwXO+IQe?=
 =?us-ascii?Q?4WPU93QKO5a96vo0pFecwUt3rVAtgTI1AazpoCZ5JxOEmNv+OpylDVT13kYr?=
 =?us-ascii?Q?FuC3HGTP/NA5lLra8362vUiCxw39neb5NON7vMhZJuzm3AplewS/eUChwYA+?=
 =?us-ascii?Q?DzAzwQKJTfqnRi+6mzBEYDQAvN9/057yec3alwQkDX7sXMfCNa2324VmyXWU?=
 =?us-ascii?Q?0JAKpqvwCAY3eOfWPWSotL6BW+Ct+/OFllo1UYChRXHliXG3R4OM9I1SF+O9?=
 =?us-ascii?Q?NpcogRvz1lSBDKNlouSMl51fx/LMLljq26tDkfjKhSxZkptJekX6THgWBqp9?=
 =?us-ascii?Q?BneQNzUxyayEF5fSGzrTyHjKHWLxFXBksZM9ITu6/WxtmsaKteem8vlsrG7f?=
 =?us-ascii?Q?FOsjIIJ4YYBVcWf0g9FNFEDMIK3ekjDQvHzf3ICzyKlpdIkCI6Hatkcp86B6?=
 =?us-ascii?Q?unF6ezsHnwwYe+lduWh+y4+NY4qGT7yj2Hhq6SZfBsX6tue1hIkMCLvlWYLf?=
 =?us-ascii?Q?+3rU0/XJtBjrNhlWuvNZWKxQfW1PWHg0JetQOEHS/kbRc5syq6VBo81Cfn2u?=
 =?us-ascii?Q?2+JTiOszPInM8bKunVsCsa8rqosGp/zZXNZ4ivhAO2SbIusu7CIzyo1Lr1Pv?=
 =?us-ascii?Q?GTOLHzrIzg5dYwKlmVI/hQGyOyMjMzSZTVFesZhf0OmpzzxtHoxf1XmiJBhz?=
 =?us-ascii?Q?/N+JQWcGT0SgFS/RbhgOghEBm77SxN76MK61JCNdTg65tP8J6xXrHHi/D8pn?=
 =?us-ascii?Q?mpq3jX2XrS6LnnbrY3OMi/vrVnwxz/0DZkn4czF8Pw604GjvhlPe6ti/lwtP?=
 =?us-ascii?Q?6XuWwFtDCUtw7pYr/6IBLGjsbak13JRTJpmU5DqzSGSQ5+A8fZD6SRH0lIZa?=
 =?us-ascii?Q?pmm9CO4UoIQDT7mag75P28vj9BUy5iDfOQwB96+hehSq9pNr7w+iOZ2YWyio?=
 =?us-ascii?Q?+/F/iI4TnLw3NH/VN5xRjQq2zeH8p+dyBwjPREKERQU4oLDP1AASAmUlA46H?=
 =?us-ascii?Q?rD7qU5sa8/lpj4cTAWJcjvvBDTtkCFmR2yELzQHwmNp5OzORAIMEuKoks6J/?=
 =?us-ascii?Q?u+uX7wpGz73bDoW2M//r9GuRRVnqeRsi1jBY16BGa9XvJnl7qQ54tf390+nh?=
 =?us-ascii?Q?Hx9GplfDcum5V8ywr9nvaMO/YPrlk8DvWN4chNmPeS+Q0gd5MyjzKU81OJKL?=
 =?us-ascii?Q?zgjs2jAq/jngpfCgDcqWOlmxZWChvoQa/LkW1FHy2UmAjkonJP7+E38aA+Uk?=
 =?us-ascii?Q?jcFlurrKan86geEG2WJ4+dmQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 359f06bf-4df3-42f7-c012-08d94861f0da
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 13:59:33.7422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R7KiM4HTXgFZ6iNOoQSiJObzvtAEdxPHib/x1DI4ewvLyeHqPuOWxqTXKiiwIP9NETMltfrIzqBgFDKfU1aMo7k832kbeLUHK0hkZevY3Sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0861
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Ani Sinha <ani@anisinha.ca> Sent: Friday, July 16, 2021 6:33 AM
>=20
> Commit dce7cd62754b5 ("x86/hyperv: Allow guests to enable InvariantTSC")
> added the support for HV_X64_MSR_TSC_INVARIANT_CONTROL. Setting bit 0
> of this synthetic MSR will allow hyper-v guests to report invariant TSC
> CPU feature through CPUID. This comment adds this explanation to the code
> and mentions where the Intel's generic platform init code reads this
> feature bit from CPUID. The comment will help developers understand how
> the two parts of the initialization (hyperV specific and non-hyperV
> specific generic hw init) are related.
>=20
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> changelog:
> v1: initial patch
> v2: slight comment update based on received feedback.
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 715458b7729a..3b05dab3086e 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -368,6 +368,15 @@ static void __init ms_hyperv_init_platform(void)
>  	machine_ops.crash_shutdown =3D hv_machine_crash_shutdown;
>  #endif
>  	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
> +		/*
> +		 * Writing to synthetic MSR 0x40000118 updates/changes the
> +		 * guest visible CPUIDs. Setting bit 0 of this MSR  enables
> +		 * guests to report invariant TSC feature through CPUID
> +		 * instruction, CPUID 0x800000007/EDX, bit 8. See code in
> +		 * early_init_intel() where this bit is examined. The
> +		 * setting of this MSR bit should happen before init_intel()
> +		 * is called.
> +		 */
>  		wrmsrl(HV_X64_MSR_TSC_INVARIANT_CONTROL, 0x1);
>  		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
>  	}
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

