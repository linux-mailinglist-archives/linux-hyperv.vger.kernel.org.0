Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEC339B757
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2019 21:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391450AbfHWTuZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 23 Aug 2019 15:50:25 -0400
Received: from mail-eopbgr690109.outbound.protection.outlook.com ([40.107.69.109]:2269
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387948AbfHWTuZ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 23 Aug 2019 15:50:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRKsbxKd2mXAOJEMnJAoZTKXZmYO16BMFwbX9Mz9L81GWZzXh27bAL1mf07iCP1fMhScwb5CwrZqDq7F0T1DlC576d+QDXYOklRT1iASEwCK8/SSjRNt0D2CzwiGWAeD7g17VJtOtqP3+D9HncqbD+W+iPiPnM+dwXxRmeEkHLFJhet9BRisd49aQ0oRJUGwlSpmtTIXc3UzJ2jvAQegqMNlBgDMbsyh0qmMsbGGAmR/Gm2YuwHpNRbJP9kou1tgxL71i+ilKCxvn9fRawElcd0EkastDJFDLQBTWVfSnaBcGm59j9mEZ9sJjv7XK2ll1tBkvNUFqJ/48v/X7S6z+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xtxnarhEnxyeKtPdSwRTSwL0jQtL0+NIsdnBJftkOg=;
 b=kzMDwgrTSyCAI45X/NBIJpzDOQChK4f3nIuy/pupELYP51WZbqvVvEEcnkzBhlbddocgS7KTWVlgJLsRO30GUgABIgXea7Chs1UGf2i12r1v2lUDT9g+XEdQ72kexfwjpQ3O7RgQKlJVpQ/1LWORnDrKTS61x3KRgej6tipqnhHYC2wCeC6H5Pby7pZoTvFGosEdKLOdP1hxzOddMbLH51mc+eBCmKccZZ9hJiTWO/Fu1TBGVUVYCwjDCVRDu+KA+hSxo355+2h6IBLnWeOd4M9GeikFcM6Uh0fLLooSo4rsPNkgsejLu6FI7WCAv6ek806b/ZtPdS53wuSkZroZTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xtxnarhEnxyeKtPdSwRTSwL0jQtL0+NIsdnBJftkOg=;
 b=WZpV/Wqz92H1X32IzJG3WUmGFfKJ6PG29pCY2e4uDvJX4N3OIirjn/MwNmzj/LWLJIwC3yei2msA2qwNnRqcg5jTOdauNLWpCCsqKvXChVJbF79r23J3m+X7ZrIL93jgXG7IyrL36kcbnzCW3m/Jq6hJ0dC1GmLQ9Vr6vUIt7gk=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0857.namprd21.prod.outlook.com (10.173.172.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.4; Fri, 23 Aug 2019 19:50:21 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::8985:a319:f21:530e]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a%8]) with mapi id 15.20.2220.000; Fri, 23 Aug 2019
 19:50:21 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 02/12] x86/hyper-v: Implement
 hv_is_hibernation_supported()
Thread-Topic: [PATCH v3 02/12] x86/hyper-v: Implement
 hv_is_hibernation_supported()
Thread-Index: AQHVVvnbeUNjfG6a0EKsx3hMtEEAZKcJJ23g
Date:   Fri, 23 Aug 2019 19:50:21 +0000
Message-ID: <DM5PR21MB0137A7EC5E51EAF8A0667359D7A40@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <1566265863-21252-1-git-send-email-decui@microsoft.com>
 <1566265863-21252-3-git-send-email-decui@microsoft.com>
In-Reply-To: <1566265863-21252-3-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-23T19:50:19.4147320Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d9b27438-246a-4a4e-b2fe-93c271246a48;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be048c08-b94f-4034-2793-08d7280321ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR21MB0857;
x-ms-traffictypediagnostic: DM5PR21MB0857:|DM5PR21MB0857:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB0857C97CA7B5B69571B2E4ABD7A40@DM5PR21MB0857.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(199004)(189003)(6436002)(33656002)(6506007)(14444005)(8936002)(256004)(102836004)(8990500004)(81166006)(81156014)(14454004)(71190400001)(229853002)(11346002)(476003)(446003)(486006)(66476007)(71200400001)(53936002)(64756008)(66446008)(9686003)(66556008)(26005)(55016002)(186003)(74316002)(86362001)(305945005)(7736002)(2201001)(478600001)(2906002)(316002)(66946007)(1511001)(66066001)(4326008)(76176011)(76116006)(99286004)(10290500003)(52536014)(6246003)(5660300002)(25786009)(7696005)(2501003)(3846002)(22452003)(10090500001)(6116002)(8676002)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0857;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kEtWy09gkbO4U7Z+VEUhzE0r4t1NuBc52WVVlcvWTjrmh/4JwH5xPhxL9dyW8FwGyQi+Wj7tjQdJuxzz4Bg26mmSJKKb7XFfh3e8CEtAeRVPE1caEO9pIGahnw5IIbNAH/Sa04H6aCBeAZqhXjoQF8vDvIfBaT5cXPQQ48NFgYtxCCMkFlfs0c+NmS5WRhDC0N44E5ohn0XLZaliBG7sZiSx3kGWJZAvWKqkrUAZej4c6+N9uHn/lC62WBHiNCoet7lSr1ihF6VSCSXm5onafSrWu4y/v2wgNHZxF/qgq71E8a8yVfHfLQhqgiOf+47y/YRaxgnyX9hfSFt32e2svlVrV3WTHFqnHYrxD06fYaVIgpcXpgh7krVkp+r9gV5OHa9H1AucStiQDzBhLsNUdFNoHRzRL7liBFtm4RwkdG4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be048c08-b94f-4034-2793-08d7280321ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 19:50:21.4253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KkUml4KTrGFW3ly3pxmos5d48qF4jzy9v4gLgze5tewOZatBNXAoAl7BI+YYYF4ePu55vhRvOG+b6ZJYIlAwJMtxPgnRll5yS9JydoYwIyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0857
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Monday, August 19, 2019 6:52 P=
M
>=20
> When a Linux VM runs on Hyper-V and hibernates, it must disable the
> memory hot-add/remove and balloon up/down capabilities in the hv_balloon
> driver.

I'm unclear on the above statement.  I think the requirement is that
ballooning must not be active when hibernation is initiated.  Is hibernatio=
n
blocked in that case?  If not, what happens?

>=20
> By default, Hyper-V does not enable the virtual ACPI S4 state for a VM;
> on recent Hyper-V hosts, the administrator is able to enable the virtual
> ACPI S4 state for a VM, so we hope to use the presence of the virtual ACP=
I

"we hope" sounds very indefinite. :-(    Does ACPI S4 have to be enabled fo=
r
hibernation to be initiated?  Goes back to my first question ....

> S4 state as a hint for hv_balloon to disable the aforementioned
> capabilities.
>=20
> The new API will be used by hv_balloon.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c      | 7 +++++++
>  include/asm-generic/mshyperv.h | 2 ++
>  2 files changed, 9 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 78e53d9..6735e45 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -7,6 +7,7 @@
>   * Author : K. Y. Srinivasan <kys@microsoft.com>
>   */
>=20
> +#include <linux/acpi.h>
>  #include <linux/efi.h>
>  #include <linux/types.h>
>  #include <asm/apic.h>
> @@ -453,3 +454,9 @@ bool hv_is_hyperv_initialized(void)
>  	return hypercall_msr.enable;
>  }
>  EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
> +
> +bool hv_is_hibernation_supported(void)
> +{
> +	return acpi_sleep_state_supported(ACPI_STATE_S4);
> +}
> +EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 0becb7d..1cb4001 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -166,9 +166,11 @@ static inline int cpumask_to_vpset(struct hv_vpset *=
vpset,
>  void hyperv_report_panic(struct pt_regs *regs, long err);
>  void hyperv_report_panic_msg(phys_addr_t pa, size_t size);
>  bool hv_is_hyperv_initialized(void);
> +bool hv_is_hibernation_supported(void);
>  void hyperv_cleanup(void);
>  #else /* CONFIG_HYPERV */
>  static inline bool hv_is_hyperv_initialized(void) { return false; }
> +static inline bool hv_is_hibernation_supported(void) { return false; }
>  static inline void hyperv_cleanup(void) {}
>  #endif /* CONFIG_HYPERV */
>=20
> --
> 1.8.3.1

