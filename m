Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D186D3546
	for <lists+linux-hyperv@lfdr.de>; Sun,  2 Apr 2023 04:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjDBCgU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 1 Apr 2023 22:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDBCgU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 1 Apr 2023 22:36:20 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021025.outbound.protection.outlook.com [52.101.62.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F0CF0;
        Sat,  1 Apr 2023 19:36:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHbq3DvbUtf5sLnfVEkofI9l1NJc4KVf+Ni/RMBGiyDOTgXVPtBI012SNZ9QljAWqoJGn1TL9tBGzpfM1q1l+yaaCQ71EDRPW9QNxn9L6z99xOgZHTFbCT4ZjhuziO14mytpKdMmYgI8n0nccEcain4EhJg6wWCZc1wZQVxpavqbPohn2EGaaeyEMbI2CkNL5Nklwi5HjKxIaNGuSO7RLE0fljQxd/BFuzwCjblLCz2PG9MbHZjkPAS9IPYDinacYuUvwp+Qq1RalXnqNJ7nPSOJLoF53+clpQ728Gp1IB7OLI2Ipm4ODUBO3doGZoRy963zewzpVU+FY8PwQxEClw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9hc6BGA4dbzirzsC9fVdXVP81YA9zRNJGLpic1ZP9I=;
 b=MhmO0n6UyUkXg6fTklUiwae9r8RyVu9AosG+qzlc3Q1tUURR4+wTmWDgGiV4SPjRWOLUcDYNr3918OogVbxQxq+dlLM5jQgyD98arQYFnYivJNpw2dyyTzVhKdXqBDtpDZFv6ddmbkkNOLqPcBsxLAvJ9KNgiy/dtA9RpD7oBLbyz+NUmwKGUI575irn11gN3elWi3nloejfd7OX2sYZlH1PKiaKJX6s1obQsYNTBg4sC3I5rANFz0gfp0Af/HIclriAAOi8+mAq1rmhFxqFiCXcna+R0OlwopoQ//X6QJZ4MGTNZhjf61itQssAb55p0RrYuVr3zWHz0ZJ0E2OuzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9hc6BGA4dbzirzsC9fVdXVP81YA9zRNJGLpic1ZP9I=;
 b=Eadn7NNIvhxK798wSurZtzUGDdp+N2hNS3AhlBPBUc1yhM0vyu4b3RProK0752Tns7KcXw5+BhP3vS/u0Y3m0ju2PsPeQrGDNvqHkvA+sRvB0XE2/fwuS+/F9zyJyo8pfgV9CsXyDPlNTUjrPUsx3ZzEYcll9Kv3AUz7lSgzcfM=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH0PR21MB1909.namprd21.prod.outlook.com (2603:10b6:510:1a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.4; Sun, 2 Apr
 2023 02:36:16 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6277.018; Sun, 2 Apr 2023
 02:36:15 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH v5 05/15] x86/hyperv: set MTRR state when running as
 SEV-SNP Hyper-V guest
Thread-Topic: [PATCH v5 05/15] x86/hyperv: set MTRR state when running as
 SEV-SNP Hyper-V guest
Thread-Index: AQHZZGRucoKoD7y5r0OA1Rf8kkYNeq8XS9nQ
Date:   Sun, 2 Apr 2023 02:36:15 +0000
Message-ID: <BYAPR21MB1688814591F2C482CC945F6FD78D9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-6-jgross@suse.com>
In-Reply-To: <20230401063652.23522-6-jgross@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0291ad30-731a-4333-bbcd-b3054b6871f1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-02T02:24:57Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH0PR21MB1909:EE_
x-ms-office365-filtering-correlation-id: 81021994-3b80-4864-3c4d-08db3323081d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wWAN8GSmm3P/GT9inpujoWdEINuvM+8Lt/iPmaeNsnWA5J+KUkGDFFZKa9tljKdR3Bfnub/FVUsfQGoJS+nJSnBM7l6qLaLNRGBGqp+pF7XlblELxBlagthTw6VD5OE3gZEIbDUf1IkNTGMinv+5EkyAHVbFFqm6GSKfkENJ4PyFUzhAWskD0SWPgg8orMext5Ihyj4oTzg5Us5RhnkcrJyIr3x1s7dwJbIP2veqtATRKdXPhJoR2xwMVvfcKw1iJIzcuaLxw5ii+pinIsYwLItFJsxIurF4JY7EsYS97V8ZlBgLCK3d6/Vbmi/hcpBY4zDws8f7n5Ce/xz9CNRSLe3U235iwBRn+NhgRxSyI7gxIisc8qz8luMVGGIAf0w7o+bN9CrUIuHakfwuf9G/n5RgrsRckil8qXr9zky8UXEb5BkzWXLqt/slLcw04KgehFM5ZJP5PWCNw60az5vn2f4YebVB9/Iwo3YvuRDT/6IHTk9fO2xlif+W6QOuDP7TUXYIzcTNIIz9Xx9s8zLf5ZmQRd8NSKheBhlLTTgwP5msP7uBV10kujL+uSV0bWYgqROrk+vXGv279Aanzp/aSRMrYsIdAMG9iaOrYBdI7xW44c9mzYTqQjyHNP1Wsw0Od+yIGh7t91EDayR2vFpLk00ZToofpJt9HkEONCUuHyk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199021)(64756008)(66446008)(66556008)(66476007)(4326008)(41300700001)(2906002)(122000001)(82950400001)(82960400001)(33656002)(55016003)(8676002)(7696005)(83380400001)(71200400001)(26005)(9686003)(6506007)(86362001)(186003)(478600001)(10290500003)(110136005)(786003)(316002)(54906003)(38070700005)(8936002)(52536014)(66946007)(76116006)(7416002)(5660300002)(38100700002)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ezuGGxXcjRuTvjW1HKDHIHqmSB9VQ57TMES7Rd/vyO+CyZlAEefseqhkP3++?=
 =?us-ascii?Q?CUAg9uYw5g5pavBf267o0ISggJcfrYkhWaHvlA/YAT5avxDHo/fX52iSCWHH?=
 =?us-ascii?Q?SUMePqF7i0jIxN4/hPmb10ItsdR9GfStS+lW0/GMchjHHnP0yplIWRZH+vp9?=
 =?us-ascii?Q?oqwT6RcY/TLOBcEMcbfVY14yCzlJSg5Lidk8GM2ZK4OEv3d0mWLoWzQAvhn9?=
 =?us-ascii?Q?6m1z47ng9cfX9Qql/iAAANnAh4ZnkT91DJxPp/xt6DXkXnmghl/60qJAoPG2?=
 =?us-ascii?Q?6H4LhKDl66gdEIDyzsoECzx2jCBcQyxtzzXS5N8l8vNW73Uu9Qklyr6bJNkn?=
 =?us-ascii?Q?d/lbQR1rSqUu3PuZkVdHanfsd76KybAVcVJHYnETkl/JZLV+xoxoPA5qmFP9?=
 =?us-ascii?Q?dSho9RBHb5MCAFuC948x5Kwo+tf8P/KQYyFCNM2tGLSZR1hbW2L7UElpVrjY?=
 =?us-ascii?Q?FkvFpfWYgMFUiyKvmGASrnRr6R7OeeaF1GeCTyAjcZmlSMOJm8ea3PYWAooa?=
 =?us-ascii?Q?tKG6yXxEWxHZs9sbvUGPWBN0HsNZyUUs36I++H2SHuaMDNhBd8Gr9pXy1VUC?=
 =?us-ascii?Q?y9N7OVxe4t4FFiORUJTHhkkNgjitCOJ+b4CG3wPHTLtSUT2xL/qSPMiFoHfX?=
 =?us-ascii?Q?IUMVGNxyYe01aT1+MAsRfWpCzmRwO0A7RErh5gygPAJRHPeuBV2dNAB6ai9l?=
 =?us-ascii?Q?0vWNJJrshbJcmAWpZnnhOgW7grKek8SB6h4J+fJlW7PPOmoJTsmzZU8XShB5?=
 =?us-ascii?Q?rZQTLDLxOkiT3Rky252MocDcawN5d1Xvw9PkfGeJxoB6AoKg/h+JJHxgKtjA?=
 =?us-ascii?Q?PkiI99j0NMeiccGavEbJfs+izlZFxs/zBQra/uxgvIE9g8vmrxXha2DSqGxK?=
 =?us-ascii?Q?1R1vN8xnGf7OfgKT6r/ORnPmbiAAmRJBkpEwgT4pOjBZmT1qy8hnsl/iYJnk?=
 =?us-ascii?Q?QiDg2XvATduGTBkTQ/cZpDX6AVkxzMSoJ+2nUjmVx0tuCYDwNSUcBKAspA0w?=
 =?us-ascii?Q?jUi73QYoKkDPkY3Pg+54ATyvId/GINkx5qwZcPLihg0m3ChWRUZ3k9VEteXr?=
 =?us-ascii?Q?plZu/OHJK/U4wt6NQQotModtOr/SgMN+R3Me3puSZDiCd/JJY6A+Qvn9JIuU?=
 =?us-ascii?Q?sCVs/MJYmyis3C6uHQzLuC0hY7nU5zwY3Yu7QWdy7BIA/aCh70crxhhxB3eS?=
 =?us-ascii?Q?NxC1HHx3jnKPU0Ufr7O+JElM8/dUyXyZu8k4MtUkZlBgJZf1Q1c3NLf+4Olf?=
 =?us-ascii?Q?IUamitzeVgqBKV7Hqdtd9u2Sah2G6BDw+d6Ks0bEljXgXvMqQfjWfUfP/J5A?=
 =?us-ascii?Q?dXSBQicbRiRCrPk4rFd+aeaIUtsqWEXLoQGj/MX0lvvna2gLFMsi6FnEttbF?=
 =?us-ascii?Q?6f4HW3DSq5cNYPwFS4HfvaFd0RLq+WQFs32GlYIjI8PUuZ68cVBqtAu1Pcy4?=
 =?us-ascii?Q?KTi1BeMlgdZ+yB5hvDNMeuP+I4+5AO2dFuR2MuV+TfGNRGJjq4K6yA3Dr8cn?=
 =?us-ascii?Q?/ogqdATpMVgs/cXukraFuVdMuTDWjyVHkFcu3Ei3mWqIqEPhuiBPFuzROK0P?=
 =?us-ascii?Q?ZEvcX4xrBRUax59J4Q8sp7QjoQKFnVG28UB3sPCMG5Ed9GJd59za0l/ayTOt?=
 =?us-ascii?Q?HA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81021994-3b80-4864-3c4d-08db3323081d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2023 02:36:15.5692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uPWunkEJbaK2iAIYoEm36fgvcMmAMYa5AEGwAhycIcNqQyZmwCvXPnn0sjQZc05u5ehLWcjSeymtfhYTfv+Z1qNCEQroWfjPj+cnwGRIZ08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1909
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Juergen Gross <jgross@suse.com> Sent: Friday, March 31, 2023 11:37 PM
>=20
> In order to avoid mappings using the UC- cache attribute, set the
> MTRR state to use WB caching as the default.
>=20
> This is needed in order to cope with the fact that PAT is enabled,
> while MTRRs are not supported by the hypervisor.
>=20
> Fixes: 90b926e68f50 ("x86/pat: Fix pat_x_mtrr_type() for MTRR disabled ca=
se")
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Tested-by: Michael Kelley <mikelley@microsoft.com>

I've tested the full v5 series in a Hyper-V SEV-SNP guest with vTOM.  All l=
ooks
good.  The following output appears in dmesg, which I think matches expecta=
tions:

[    0.004000] MTRR map: 0 entries (0 fixed + 0 variable; max 0), built fro=
m 0 variable MTRRs
[    0.004000] MTRRs set to read-only
[    0.004000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT

The page attributes listed in /sys/kernel/debug/x86/pat_memtype_list are
"write-back" in the expected cases, and the "mtrr" x86 feature no longer ap=
pears
in the "flags" output of "lscpu" or /proc/cpuinfo.  /proc/mtrr does not exi=
st, again
as expected.

> ---
> V2:
> - new patch
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index f36dc2f796c5..0a6cc3cf8919 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -34,6 +34,7 @@
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/numa.h>
>  #include <asm/coco.h>
> +#include <asm/mtrr.h>
>=20
>  /* Is Linux running as the root partition? */
>  bool hv_root_partition;
> @@ -408,6 +409,9 @@ static void __init ms_hyperv_init_platform(void)
>  #ifdef CONFIG_SWIOTLB
>  			swiotlb_unencrypted_base =3D
> ms_hyperv.shared_gpa_boundary;
>  #endif
> +
> +			/* Set WB as the default cache mode. */
> +			mtrr_overwrite_state(NULL, 0, MTRR_TYPE_WRBACK);

The placement of this call needs to change due to a patch set I submitted a=
nd
that Boris has accepted into the 'tip' tree for the 6.4 merge window (so it=
's now
in linux-next).  The call should be placed in the function hv_vtom_init() i=
n the
source file arch/x86/hyperv/ivm.c.  Anywhere in hv_vtom_init() is fine -- I=
 would
suggest at the end.

Minor request: In a v6 of this patch set, please include me on all the patc=
hes in
the series so I can easily keep track of how it is progressing.

Michael

>  		}
>  		/* Isolation VMs are unenlightened SEV-based VMs, thus this check: */
>  		if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
> --
> 2.35.3

