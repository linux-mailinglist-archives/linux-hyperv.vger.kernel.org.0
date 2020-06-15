Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1B21F8BD5
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Jun 2020 02:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgFOAHM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 14 Jun 2020 20:07:12 -0400
Received: from mail-eopbgr1320121.outbound.protection.outlook.com ([40.107.132.121]:32436
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbgFOAHM (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 14 Jun 2020 20:07:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuXAtmeXaORzZ86geSp30WWTc1/uqZM2lTI4rUMvUIs7BMIfeMtx8r5VUGz251UoBzIQowSJf0fQlYPJAttmHdfaYvko5Sb/MV514sDcr4xbExRKlequetiyqRsktNI3D+GwJ/ISxi/Nt5zzpRUcnIiRecQcec1k40SqRKbruPCT9xTPk17CZDXXvFoODRdx2uoHHU0xTAbhM4uwKpPxkv7AKV5enmbKNZWQRE+qAsZrpISo52XevpTFXGjDwMs/X96Z0kL0B0ISabGInk+pTzyDq12pCUvHoS+D3A5ScbRS90pvmhR8f7f2/OtPhLHixhR07hL2bxvaTAUFPWIOAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ps6TJVCJDX0WbxdfpwNIgfI98+8Fmnn2PPO89ccLQwE=;
 b=X187DfUkEv7dQjVg5K+eyBqt5kCYFTT3np+WZ9yKEmH4s4K2RG6ccsM8M5qXoFLPgOKUB09nDGm3bQ/1uWYjYYpbntdlqdfZLQdJxr96GSf7r2INtzxa+ZE8lMIxGhRWb+3iuWZ74EXHto2jxtwLZQkGt8I1V/6lh8mprY7PdIPoNnIdwBtZ7Po8VTTZe0xRlU9Kk+R6Jok9GoI85G46V2ivbWg484+sOi4DAhq98m9S823Gjjs7658mQ49KcfjoOMeRWaPyysESXTLzZ+qsMVeT3Sz/oe1nhNOrTAPMzDFRVfGcTT6hCfwsdz6RwrLvsKXR1qOBG4pjifaLiSYrJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ps6TJVCJDX0WbxdfpwNIgfI98+8Fmnn2PPO89ccLQwE=;
 b=Tv70pnXEPjD0v4K4VoTl3PMA53B3yb/SiV/GKku5dq+tp6pHJ3iGdK6Z4OkemzSOXaaIYv6PFQRYkbXN2t+cOxKdWaU8oB8ofY4QonX/fM2cXN/LI+H1dBm/DFaymirtPgHa9tWbBBT5hmKH6aEMCy+3OD2pxW078U0Hxjrq1x4=
Received: from PS1P15301MB0331.APCP153.PROD.OUTLOOK.COM (2603:1096:300:83::10)
 by PS1P15301MB0028.APCP153.PROD.OUTLOOK.COM (2603:1096:803:10::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.8; Mon, 15 Jun
 2020 00:06:48 +0000
Received: from PS1P15301MB0331.APCP153.PROD.OUTLOOK.COM
 ([fe80::98bc:8bc3:2914:74d1]) by PS1P15301MB0331.APCP153.PROD.OUTLOOK.COM
 ([fe80::98bc:8bc3:2914:74d1%8]) with mapi id 15.20.3131.008; Mon, 15 Jun 2020
 00:06:48 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "namit@vmware.com" <namit@vmware.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v3] x86/apic/flat64: Add back the early_param("apic",
 parse_apic)
Thread-Topic: [PATCH v3] x86/apic/flat64: Add back the early_param("apic",
 parse_apic)
Thread-Index: AQHWN2t1B9ErZU4HUkGcNEem5kz1iqjY4oXQ
Date:   Mon, 15 Jun 2020 00:06:47 +0000
Message-ID: <PS1P15301MB0331C9AFBEA8D267C346F93FBF9C0@PS1P15301MB0331.APCP153.PROD.OUTLOOK.COM>
References: <20200531164859.43903-1-decui@microsoft.com>
In-Reply-To: <20200531164859.43903-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-06-15T00:06:43Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b2946bee-8892-4dae-b8e0-f2be4f724c0f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:b8fb:6bb:502d:341f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7aa5a522-3b15-44f5-2b65-08d810bfff4d
x-ms-traffictypediagnostic: PS1P15301MB0028:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PS1P15301MB002846139E3A49CAA732EB63BF9C0@PS1P15301MB0028.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dlbBcFDx5VYVEYVWZzXP02d0I5Z5Lwqzm20HDhF+6jbc5BdiOrQnwnN98OT6zFeCh88nxQW8tLkbQLhE/kUzGwFbyoFdYPe/OBT0y99RvBiL+SusmkSa988vKjIHLqBL8qCDMTdJGH1Hcq5M3pQod25kkMVxwG/QHMORvbEYv5s65si3vwxOOD6C19ah5Zsb6OFRhTQqyEGWOyo413KevnxgJrtKLjEHMut9pFoZ7ieRCigmtRqspN94EGhodOyI2aTxJkGczl1hJW81h8K4y4DN88ccsrMFLUMAdFvYg0xecOsbk0OuHIkh5kU0usYkWPds66zSRpPHO6qew0BCP/Fsv3OmPa6Rk6MD5FAs+G6LECNlXOtaSnPofUwh0FMJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1P15301MB0331.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(64756008)(66556008)(316002)(66476007)(8990500004)(55016002)(6506007)(53546011)(66446008)(33656002)(54906003)(2906002)(110136005)(478600001)(8936002)(9686003)(8676002)(71200400001)(6636002)(4326008)(52536014)(186003)(82950400001)(82960400001)(10290500003)(86362001)(76116006)(83380400001)(5660300002)(7696005)(7416002)(66946007)(921003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: G1DwDlI5HXk+y5Y+jZk2XzMAW+yerItGNzDs+adL5ExEeCf/AGSS3D6P5m/zVF8LDtrml4/nC1I3Xe0lyrgUI9zRYn+M9js5ltcV/Bvmk+mlB1EwIsDA57x9fZcdTcdjn2bgWJaLDvq0trIaJ7ZtqtHQ6zZn8uy6+oEJCOTMwLf0aHNT/effGvMX/3m6tY3LN0OlL6yZhYzwf4ckIh0nzqyC0qVqFkSSEdfv0rMD7j+lK1vU8dgTfKvn4Bi+9b1ZoOlIg3gyKtprivEbrHEdwbpIr3MluRowgZjescYAsMGBijQ744E8tPnaQrOaFmQ6wyZkbrI++Pav8RvHeIYCR3rKBMrMw30G9NVkoJkThrQfbggFz+25TWlvzD9S1MR9YiLddRqrKUo57SVL8IMwCKDwPDMsQoGWhbW2oGreB3OtDQ4hjbhtIixURknFdnoDRzXoP9zzmTzA6vzRoQDWdSyO1z3JnbDG3ygcidkASCcAImexiW9effhAKZvyrulzU2ngdTlTFVbijh9GjPdozyy7/JOFue+2e0h4K+Ns840=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1P15301MB0331.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa5a522-3b15-44f5-2b65-08d810bfff4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 00:06:47.7402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OLWQ9Ko/ZfWvSh51Fn65Hmep72t/Xe16SwGr07WLf34KCn7Lpe0rHGPwkPixQ1QqzNV1s1TCyYl5QAQMPE2IOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1P15301MB0028
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Dexuan Cui <decui@microsoft.com>
> Sent: Sunday, May 31, 2020 9:49 AM
> To: tglx@linutronix.de; mingo@redhat.com; rdunlap@infradead.org;
> bp@alien8.de; hpa@zytor.com; x86@kernel.org; peterz@infradead.org;
> allison@lohutok.net; alexios.zavras@intel.com; gregkh@linuxfoundation.org=
;
> Dexuan Cui <decui@microsoft.com>; namit@vmware.com; Michael Kelley
> <mikelley@microsoft.com>; Long Li <longli@microsoft.com>
> Cc: linux-kernel@vger.kernel.org; linux-hyperv@vger.kernel.org
> Subject: [PATCH v3] x86/apic/flat64: Add back the early_param("apic",
> parse_apic)
>=20
> parse_apic() allows the user to try a different APIC driver than the
> default one that's automatically chosen. It works for X86-32, but
> doesn't work for X86-64 because it was removed in 2009 for X86-64 by
> commit 7b38725318f4 ("x86: remove subarchitecture support code"),
> whose changelog doesn't explicitly describe the removal for X86-64.
>=20
> The patch adds back the functionality for X86-64. The intent is mainly
> to work around an APIC emulation bug in Hyper-V in the case of kdump:
> currently Hyper-V does not honor the disabled state of the local APICs,
> so all the IOAPIC-based interrupts may not be delivered to the correct
> virtual CPU, if the logical-mode APIC driver is used (the kdump
> kernel usually uses the logical-mode APIC driver, since typically
> only 1 CPU is active). Luckily the kdump issue can be worked around by
> forcing the kdump kernel to use physical mode, before the fix to Hyper-V
> becomes widely available.
>=20
> The current algorithm of choosing an APIC driver is:
>=20
> 1. The global pointer "struct apic *apic" has a default value, i.e
> "apic_default" on X86-32, and "apic_flat" on X86-64.
>=20
> 2. If the early_param "apic=3D" is specified, parse_apic() is called and
> the pointer "apic" is changed if a matching APIC driver is found.
>=20
> 3. default_acpi_madt_oem_check() calls the acpi_madt_oem_check() method
> of all APIC drivers, which may override the "apic" pointer.
>=20
> 4. default_setup_apic_routing() may override the "apic" pointer, e.g.
> by calling the probe() method of all APIC drivers. Note: refer to the
> order of the APIC drivers specified in arch/x86/kernel/apic/Makefile.
>=20
> The patch is safe because if the apic=3D early param is not specified,
> the current algorithm of choosing an APIC driver is unchanged; when the
> param is specified (e.g. on X86-64, "apic=3Dphysical flat"), the kernel
> still tries to find a "more suitable" APIC driver in the above step 3 and
> 4: e.g. if the BIOS/firmware requires that apic_x2apic_phys should be use=
d,
> the above step 4 will override the APIC driver to apic_x2apic_phys, even
> if an early_param "apic=3Dphysical flat" is specified.
>=20
> On Hyper-V, when a Linux VM has <=3D 8 virtual CPUs, if we use
> "apic=3Dphysical flat", sending IPIs to multiple vCPUs is still fast beca=
use
> Linux VM uses the para-virtualized IPI hypercalls: see hv_apic_init().
>=20
> The patch adds the __init tag for flat_acpi_madt_oem_check() and
> physflat_acpi_madt_oem_check() to avoid a warning seen with "make W=3D1":
> flat_acpi_madt_oem_check() accesses cmdline_apic, which has a __initdata
> tag.
>=20
> Fixes: 7b38725318f4 ("x86: remove subarchitecture support code")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> Changes in v2:
>   Updated Documentation/admin-guide/kernel-parameters.txt. [Randy
> Dunlap]
>   Changed apic_set_verbosity().
>   Enhanced the changelog.
>=20
> Changes in v3:
>   Added the __init tag for flat_acpi_madt_oem_check() and
> physflat_acpi_madt_oem_check() to avoid a warning seen with "make W=3D1".
>   (Thanks to kbuild test robot <lkp@intel.com>).
>=20
>   Updated the changelog for the __init tag.
>=20
>  .../admin-guide/kernel-parameters.txt         | 11 +++++--
>  arch/x86/kernel/apic/apic.c                   | 11 +++----
>  arch/x86/kernel/apic/apic_flat_64.c           | 31 +++++++++++++++++--
>  3 files changed, 40 insertions(+), 13 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt
> b/Documentation/admin-guide/kernel-parameters.txt
> index 7bc83f3d9bdf..c4503fff9348 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -341,10 +341,15 @@
>  			Format: { quiet (default) | verbose | debug }
>  			Change the amount of debugging information output
>  			when initialising the APIC and IO-APIC components.
> -			For X86-32, this can also be used to specify an APIC
> -			driver name.
> +			This can also be used to specify an APIC driver name.
>  			Format: apic=3Ddriver_name
> -			Examples: apic=3Dbigsmp
> +			Examples:
> +			  On X86-32:  apic=3Dbigsmp
> +			  On X86-64: "apic=3Dphysical flat"
> +			  Note: the available driver names depend on the
> +			  architecture and the kernel config; the setting may
> +			  be overridden by the acpi_madt_oem_check() and probe()
> +			  methods of other APIC drivers.
>=20
>  	apic_extnmi=3D	[APIC,X86] External NMI delivery setting
>  			Format: { bsp (default) | all | none }
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index e53dda210cd7..6f7d75b6358b 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -2855,13 +2855,10 @@ static int __init apic_set_verbosity(char *arg)
>  		apic_verbosity =3D APIC_DEBUG;
>  	else if (strcmp("verbose", arg) =3D=3D 0)
>  		apic_verbosity =3D APIC_VERBOSE;
> -#ifdef CONFIG_X86_64
> -	else {
> -		pr_warn("APIC Verbosity level %s not recognised"
> -			" use apic=3Dverbose or apic=3Ddebug\n", arg);
> -		return -EINVAL;
> -	}
> -#endif
> +
> +	/* Ignore unrecognized verbosity level setting. */
> +
> +	pr_info("APIC Verbosity level is %d\n", apic_verbosity);
>=20
>  	return 0;
>  }
> diff --git a/arch/x86/kernel/apic/apic_flat_64.c
> b/arch/x86/kernel/apic/apic_flat_64.c
> index 7862b152a052..da8f3640453f 100644
> --- a/arch/x86/kernel/apic/apic_flat_64.c
> +++ b/arch/x86/kernel/apic/apic_flat_64.c
> @@ -23,9 +23,34 @@ static struct apic apic_flat;
>  struct apic *apic __ro_after_init =3D &apic_flat;
>  EXPORT_SYMBOL_GPL(apic);
>=20
> -static int flat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
> +static int cmdline_apic __initdata;
> +static int __init parse_apic(char *arg)
>  {
> -	return 1;
> +	struct apic **drv;
> +
> +	if (!arg)
> +		return -EINVAL;
> +
> +	for (drv =3D __apicdrivers; drv < __apicdrivers_end; drv++) {
> +		if (!strcmp((*drv)->name, arg)) {
> +			apic =3D *drv;
> +			cmdline_apic =3D 1;
> +			return 0;
> +		}
> +	}
> +
> +	/* Parsed again by __setup for debug/verbose */
> +	return 0;
> +}
> +early_param("apic", parse_apic);
> +
> +
> +static int __init flat_acpi_madt_oem_check(char *oem_id, char
> *oem_table_id)
> +{
> +	if (!cmdline_apic)
> +		return 1;
> +
> +	return apic =3D=3D &apic_flat;
>  }
>=20
>  /*
> @@ -157,7 +182,7 @@ static struct apic apic_flat __ro_after_init =3D {
>   * We cannot use logical delivery in this case because the mask
>   * overflows, so use physical mode.
>   */
> -static int physflat_acpi_madt_oem_check(char *oem_id, char *oem_table_id=
)
> +static int __init physflat_acpi_madt_oem_check(char *oem_id, char
> *oem_table_id)
>  {
>  #ifdef CONFIG_ACPI
>  	/*
> --

Hi tglx and all,
Since v5.8-rc1 has been out, I guess you may have some cycles to
take a look at this patch?

Thanks,
-- Dexuan
