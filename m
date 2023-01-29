Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119B867FCC1
	for <lists+linux-hyperv@lfdr.de>; Sun, 29 Jan 2023 05:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjA2EoL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 28 Jan 2023 23:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2EoJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 28 Jan 2023 23:44:09 -0500
Received: from BN6PR00CU002-vft-obe.outbound.protection.outlook.com (mail-eastus2azon11021023.outbound.protection.outlook.com [52.101.57.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63E2227B9;
        Sat, 28 Jan 2023 20:44:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsePo2AQw4KwPlBJzK2dGzHdgZib3pQ/80imZTu1JXfg3UcVMBJOCeTA9Lb6aMMqOY91Am07Al7rR7tbKb/WbHguWMkv6e0h8ZH4x09uI6019ohI8eYw8MDcd+vNvxy4l3/5r4j8uCywUCKZPelNNWyq82i9v5JtJdRdePeR9zEHdCwUZwP0D8lJiiuJjJEEMg3s/yJQeKb20AEU4p/nx5eCl+Zs79VzKpbO6HgAVe0Hbnu5+P2CTKV5RybBqJW4AW+G14+CdtVRW11oddeLd0H8H1syTpbZZpUmvA9HyrF+8vtFcuGAu3BadbK/mUcBxWA2Sujznvkc6MxqbvZlSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6fXV3E/4nsIh3RQzckT+E/0qgsslhEoLdJnUttk2ao=;
 b=jZzEhxSL0K8fkvHeb3cvIMW1fgAcchqiblZ7tKHYs92B8tQA+MFmZPGtXDKMQVDP25BARfLIaQms+/P22mo74tKmv7koSVqHjbACtXZyusKoBtBP8BaNN+/y1+NycrqOg8JvfRlg4P1KWbgr+PC64ZhvTg1Cn7Y0Yh1k3aasRPCkMFngnhAxFS/P4jJBFJbGk6ojMr2KywvrV/rxaRyn9pWZSESc0IRBsXj9weWYA41D1CzbzLjXQn5MABiUo5TdKOjarP40vZqQ0RY2jHoGL0aqVx0R0iaf6F+Kx1ImSt3XitxW6n0iBudhrgypztSrEU0zzb/kYY+Y54E91TpGqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6fXV3E/4nsIh3RQzckT+E/0qgsslhEoLdJnUttk2ao=;
 b=MGaEhLLwrxBACtPLIkynAV806pcdkcvp+En4zMq87E1Zf0tFAdrERUquVMcjGItdDtGFDl1a76gkfV0iplZa1xJqlOwduUVtqxl9RRjmmsMFXF8L+3jUpy5LP9riF/uUAwhFAwkrQdDsbKiSdR/JpWAwzZy3hHEmOTtJNQY4Ogw=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CY5PR21MB3541.namprd21.prod.outlook.com (2603:10b6:930:e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.4; Sun, 29 Jan
 2023 04:44:06 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e%6]) with mapi id 15.20.6064.019; Sun, 29 Jan 2023
 04:44:05 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jeremi Piotrowski <jpiotrowski@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: RE: [RFC PATCH v1 4/6] x86/amd: Configure necessary MSRs for SNP
 during CPU init when running as a guest
Thread-Topic: [RFC PATCH v1 4/6] x86/amd: Configure necessary MSRs for SNP
 during CPU init when running as a guest
Thread-Index: AQHZL0sF7IY/gTgB3kiNNeNLUHak96602Ojw
Date:   Sun, 29 Jan 2023 04:44:05 +0000
Message-ID: <BYAPR21MB1688094AE8B2D0EA02A17335D7D29@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230123165128.28185-1-jpiotrowski@linux.microsoft.com>
 <20230123165128.28185-5-jpiotrowski@linux.microsoft.com>
In-Reply-To: <20230123165128.28185-5-jpiotrowski@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=05fbd2ca-0e34-4eb7-8b66-0d8f68170241;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-29T04:40:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CY5PR21MB3541:EE_
x-ms-office365-filtering-correlation-id: 3f9f581e-7603-4575-9d22-08db01b373cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8YuaEmTaQeM8MPjBdlhTynu35CUPvD66nmYZYoRBu2McLSpIvxJ3p8aJoxuF6Mb51yMJYeFmZRpUF1l8Jhj6E5qtpgVNpdtbX+JWYUdakQqX230jIoFQgfh+LCpoMQK6iUAIWBHlyHpU41UJSYgOBxJA5XDNO/FDFa8eCquYndU1h4BboNqqnSrOqKg75zHFHhLuH/tnW+AGAd5HExCE8gnVtr++g94LUrn8y3vOhBhuQqhs2VHOE5hLl5UifFA6iKXeoWi0UeoCXu3ki74Jkp+xsqEq/7uD+E+VMUXF7EkNOStzWTBRXCHWVIFmJiqxaGm4bszymzrmAjNBAXg0X5s4TWmX9/MkNvNpp9c7D3NNGzYR4zdfvUlhvZqOPs/a5+PzauSoWgRfrvWbGOJVxTwYiBTm2TbY/OFet45MbS5j+LOmR68ECRrAyCc5QVj+LiflprMl+LT7/Fe8+ELx17WAaQmB1pRc38aE/5Cr9npQfJjhcAckkeeprGJjUp4cvbIbicqwqxHKezSYVibjdfs9EZMDbMQyW7otTOruOVTQumCQxqM3ysvrYbL6Rl+nhxMIEwu9B3rAm+L/F00kU1XBEyhL85gmmSLReNhDLhSeiXsc9UH1drgLDchDMulNdeELhLX/cnUqwhSy5hVIRxY4sSWVrk/I1YqA6YXXiUSWxHHXORzLCzS4TNlHvDFfas13Bts8Lsq5euQWj2nwXSJTT0S9QMi0ZmL39QVXCrLG/5Ksv4rxqRJaM6lNMY6c
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199018)(64756008)(82950400001)(5660300002)(122000001)(38100700002)(7416002)(52536014)(76116006)(41300700001)(4326008)(2906002)(8936002)(66476007)(82960400001)(26005)(9686003)(66556008)(6506007)(8676002)(33656002)(55016003)(186003)(66946007)(110136005)(38070700005)(66446008)(316002)(8990500004)(71200400001)(7696005)(54906003)(83380400001)(478600001)(86362001)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mh7+mcCLRcE9bOx5EPhbNDdIWbvZOpp8zXUnuhEHHZJq+MhqGuHCDhrD/ToG?=
 =?us-ascii?Q?fBUPffRRBZXuYEFFifqMdPKoCCEYNAH8Nk/vAt07YYU1nT4WBfiu1y6Lpg4u?=
 =?us-ascii?Q?RfH+6m18kE1akKOGfcrc5LycuFmVZpTewFFOpfBbwAT8uxkqrHxT96GXq5dM?=
 =?us-ascii?Q?oy4k6Xk5BqCTh5P1VekgN/hl4OezOjSIQrtRKAFPlRkbeCgjwjmPvJXr7JIE?=
 =?us-ascii?Q?prWEKs8e6bVkor4vPiBQ8VVSzGkqipcvKu1nhGlJclP21DoS4IJkqJ7aCOMV?=
 =?us-ascii?Q?RsKzv3zBoieLFMF8ADd1+636z+NIfUDqXw5e2bjGv2wvqMHAk9SxLhbzrplN?=
 =?us-ascii?Q?kmYcWj3j0mkj6kR6LdR9CYTl7I6I4IFPVhjDLUQUM8/NWlAEVbzF1Dcu4/eW?=
 =?us-ascii?Q?CB8RBshaZHhBtWVR/ggkRssraluNCUFtPCX55KLjXLDyI1Zgl4BLKCA2yqyd?=
 =?us-ascii?Q?lCe7vGNMTvri18lPvioWqpOw2sYdfPQNt+nczPWMs+vnrpuMWVQI/wftkz0b?=
 =?us-ascii?Q?6W4Aq3tyOv0T6xC18DtBTw3n+KltSvj4+1V7kHBYeRyxV4ONbl7i4629yP0i?=
 =?us-ascii?Q?/D3VxKCRYuVvWRnU9OuCs5pqjPfPRcv7hhsfm22c9MFy6eexSLgzP+xOZplW?=
 =?us-ascii?Q?2WeKy96v65MemH7GethF1TNii0qIvyO8Ny/ZkXNhUNC7c6ipBj1FLHIXkEKe?=
 =?us-ascii?Q?fh38xmez/hGPb1ftR3CVLiBxAdCSqpLVY5lNLTGuTLbLhxx4KRy1D0xxBGRr?=
 =?us-ascii?Q?hBL71qR5jWfwXp8GdHseaMOi+xgMu7iupg8pQgo7H6Va11Iw8ZVaxhT/5pn3?=
 =?us-ascii?Q?PAWN6WdqnVaiXfZMk12//XEEJlvBZYy4tox0i75chQc09R6MU4AGxI0aNL/Q?=
 =?us-ascii?Q?mx151FO+ArQUnOmPcZe8A1sRYrxPOrCn2h433r6UMB5QMPkX5x3C9jv8wEMj?=
 =?us-ascii?Q?2HD3mRCgLyXGHmBttyf7aU5odCoo5bcUyAVebQFofFOLJRGNYCpabNImFw+E?=
 =?us-ascii?Q?iANwgrb5He1u0FqMamzXcurc0wMYg5fG2q4UISM3C/Xhv/agKT6SK81X9qxC?=
 =?us-ascii?Q?jBorCpwOMLeb7MGPVwySf3FZLtVahY1TwrnNFTFPQLz+nkROQbh9LWIzC1G5?=
 =?us-ascii?Q?8LyZBLYGJVpss5Ke0PiSziYU5jjDnJTtibsr/vQuqJdX1NKsu8a1N+wlGBVl?=
 =?us-ascii?Q?61wSyXMkw1Lb0JOUVwN/F6tvvat2kRZ5+PtUKN4OAa004JTn7YUAsJdYQEpQ?=
 =?us-ascii?Q?YV65IckKzOAkMoAzH7rtwJ10W9J43O5ucMFOOhpC1qkubplhgej9aqO6JvLn?=
 =?us-ascii?Q?rIAnuzypnSBYT7NC1kvjB49sX0Z1dVfzl6fa8cmDSPBY2G3W5C8sxvm5I9WM?=
 =?us-ascii?Q?z/uMz9hZNEkQx4NPj3o+sHH8vujV6TcPq21UVdPD4PKVs4LMl8PFjmtr7GkZ?=
 =?us-ascii?Q?HT3m2zdUkfu3KOHc6MZQg8FFQzaS4lMS/rvyLo6FzTmM2aBx8iCn3KxKyl0g?=
 =?us-ascii?Q?K40WQX2sn23BGVfOXDMvgJpnetsQnya1pW6gXAlBuqbC1eZJ8MrFsV2JAcmh?=
 =?us-ascii?Q?S0JQF7d4hBjg+0UoTP0WnxFURf9mGO5F7eKchMII3p0NP3z01Hm9N5Z/Nt2I?=
 =?us-ascii?Q?4w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9f581e-7603-4575-9d22-08db01b373cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2023 04:44:05.6504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OeAMDQuzTq/m6RW4ClWOgx19jZ9OCfv+09bIj+ekVrbTpchRVMwzUc4d1iCKvONxW6KYBCQ35/QLNVRW91vWAy5vwj6ekqSZHr6YKbh6JBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3541
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com> Sent: Monday, Jan=
uary 23, 2023 8:51 AM
>=20
> Hyper-V may expose the SEV/SEV-SNP CPU features to the guest, but it is
> up to the guest to use them. early_detect_mem_encrypt() checks
> SYSCFG[MEM_ENCRYPT] and HWCR[SMMLOCK] and if these are not set the
> SEV-SNP features are cleared.  Check if we are running under a
> hypervisor and if so - update SYSCFG and skip the HWCR check.
>=20
> It would be great to make this check more specific (checking for
> Hyper-V) but this code runs before hypervisor detection on the boot cpu.

Could you elaborate on why we would want this check to be Hyper-V
specific?   Per my comments on Patch 3 of this series, I would think the
opposite.  If possible, we want code like this to work on any hypervisor,
and not have Hyper-V specific behavior in code outside of the Hyper-V
modules.  But I don't know this code well at all, so maybe there's an
aspect I'm missing.

Michael

>=20
> Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
> ---
>  arch/x86/kernel/cpu/amd.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index c7884198ad5b..17d91ac62937 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -565,6 +565,12 @@ static void early_detect_mem_encrypt(struct cpuinfo_=
x86 *c)
>  	 *   don't advertise the feature under CONFIG_X86_32.
>  	 */
>  	if (cpu_has(c, X86_FEATURE_SME) || cpu_has(c, X86_FEATURE_SEV)) {
> +		if (cpu_has(c, X86_FEATURE_HYPERVISOR)) {
> +			rdmsrl(MSR_AMD64_SYSCFG, msr);
> +			msr |=3D MSR_AMD64_SYSCFG_MEM_ENCRYPT;
> +			wrmsrl(MSR_AMD64_SYSCFG, msr);
> +		}
> +
>  		/* Check if memory encryption is enabled */
>  		rdmsrl(MSR_AMD64_SYSCFG, msr);
>  		if (!(msr & MSR_AMD64_SYSCFG_MEM_ENCRYPT))
> @@ -584,7 +590,7 @@ static void early_detect_mem_encrypt(struct cpuinfo_x=
86 *c)
>  			setup_clear_cpu_cap(X86_FEATURE_SME);
>=20
>  		rdmsrl(MSR_K7_HWCR, msr);
> -		if (!(msr & MSR_K7_HWCR_SMMLOCK))
> +		if (!(msr & MSR_K7_HWCR_SMMLOCK) && !cpu_has(c, X86_FEATURE_HYPERVISOR=
))
>  			goto clear_sev;
>=20
>  		return;
> --
> 2.25.1

