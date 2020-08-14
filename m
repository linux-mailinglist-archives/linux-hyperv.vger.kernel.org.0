Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B61B244A6D
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Aug 2020 15:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgHNNcP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Aug 2020 09:32:15 -0400
Received: from mail-co1nam11on2103.outbound.protection.outlook.com ([40.107.220.103]:38849
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726237AbgHNNcO (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Aug 2020 09:32:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDLCgp/yBHGCNpY9J2JV+2HcosIiWPrXmU3RNl0pyJ3DYCXfdV9l8mp4qdZj/ZUhSvo+ZTmFbMGx/XOw06z0M1a6OS2cC7EQzriGnVG6y8UvhL5nZNA993nPFluOedEgj/gXak++RAP5dzscVR/tVjarDDKVDGNWeUdCrzLmGx9iGjkbCWJPhi1iV5A0kzcEqfFOrqAWvrn6MSNVotqyUSZ5BECqWs4ui1BdiachPpmuHonCEpmaXtc4En6GjeEBf3khAK+d/qnkDz2dRBx+J2gWiG1Hk8biC8Ii8GGUVD2I+12zz8erz7LXU6zgQH3FJryUIqU4gUKlxU+DOBmhWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7fk+nE1Is0N7kHr8pE0x+NwB2o4qD3Ib6jzhrh2oYU=;
 b=nfMclI9SN02kWHB7FaW26gvH21kP+WOKkzLaHmC44H6t/RIW/1K2iOPFWP/axr68FFrkz2hpAfNHcdV494CLMEw7csIFcxsH1cnZrKlor4IEsuJz0tRNE21/PEUjTT2r5CSU9C/qaOOZSQoXtgKV1/eOYjM7YSW6D8NZoBA5KrecZOQMisigqFA5BeoJ5cGk6BL+cRacvCb1c8JE4ks0EWmF71D3rIuP49sYftlT/vzwSdTO91eNelJqp6yLpuKNf9zkPkpTiOjK5VoXn7Rr06QL+4ittY+WFEjUZlelitqoNIb6TZcfx+6i8LPM3tJjkXufmDkMsOxGdzSlWusaOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7fk+nE1Is0N7kHr8pE0x+NwB2o4qD3Ib6jzhrh2oYU=;
 b=jdnHWE9r/2Z0cV3KulCL6DFVnQp+92iLLBQ/kR1BUg5nkOwdv3QVg+1+WA5SXsc7408uFSOsDTq+MlTBYx1XnlM5cGu1CpzjMpq7lCZOO53wVJ1Xif6/pnIzNnVPWV+PIgi/DojaWoc3a+SEU2fiGyi/dgx1qAI8KO1qf+r29LM=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0923.namprd21.prod.outlook.com (2603:10b6:302:10::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.5; Fri, 14 Aug
 2020 13:32:12 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407%9]) with mapi id 15.20.3305.017; Fri, 14 Aug 2020
 13:32:12 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [PATCH 1/1] Drivers: hv: vmbus: Add parsing of VMbus interrupt in
 ACPI DSDT
Thread-Topic: [PATCH 1/1] Drivers: hv: vmbus: Add parsing of VMbus interrupt
 in ACPI DSDT
Thread-Index: AQHWcczKSYf6p85IYUulglZB/fkqp6k3W0mAgAA+3SA=
Date:   Fri, 14 Aug 2020 13:32:11 +0000
Message-ID: <MW2PR2101MB1052649114BC9A0396FB8905D7400@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1597362679-37965-1-git-send-email-mikelley@microsoft.com>
 <20200814094403.uhgrc74khr5vcyva@liuwe-devbox-debian-v2>
In-Reply-To: <20200814094403.uhgrc74khr5vcyva@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-08-14T13:32:10Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0d044122-5ea9-480e-8b20-24288e093990;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eab0303b-cac2-4dfe-620f-08d84056736f
x-ms-traffictypediagnostic: MW2PR2101MB0923:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB0923AEAFCCE5B21FF58D3122D7400@MW2PR2101MB0923.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:549;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZhIj5Zz/X3Jh82jQS2t8tkB/I9LfMzhAxgn5vpHauesEo6Y8uOfa49mAzuhbnFqUAdWt6wAM7DlzJmxux3H/G/ZWk/LYEEX3Nyuu40abK4tWuxOGd5m84xLVi3Nrno7wASyulSp0RJ6k7KBndSMlvWpNQ8o97W+k8w3iG4fDAH2iyDByYSMKyxfOQ5IHtgqNRjYH30YacGzlS3EPj+9YuDy8lSxl1vE4KhfrHlbU5HJj0FKBfOQsLJdN9nd5O/xRtD5Aucm2oa5vV842UG97ZE79koh+wxRb7YwhE8TCyF+zTdgeDWO79+m+mkblEIK/2KfMdnQVfZzcFgQDJV7Zyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(33656002)(6506007)(4326008)(66446008)(52536014)(186003)(5660300002)(82950400001)(82960400001)(10290500003)(76116006)(26005)(64756008)(66476007)(7696005)(66946007)(66556008)(71200400001)(6916009)(8990500004)(2906002)(8676002)(9686003)(86362001)(55016002)(8936002)(478600001)(83380400001)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: lAwr1jZNQxo1j+7A8H/2I8c/t4Q+Lil0OB35jKUQuZnFk/D0zZKwV6TYAqgJ7r/12IOJZ1S80BQMk9Euxdjt201W0AbbzBg0UySahYVPnlKJT79WSv4hh6Qr2xoc8TjTYSZV2jjzaGrMbaYLAJuLOXcnK3NC28YT7THKUjtQ59V2O5SEkE7zEa/yulGA8QfTXvX5RJ0SskOB0lFPEZX2vVhrC1JUCAQTMGBXLbceprpN6cguSWy6K1GuX+duq4UrifEZ+7/11Uddff8si8hup7xqvWv7Vk/QmsblHU/m8CN0Blh+WPFqEMFpNcfaWvIgWeWv11U7Bqr3P5dmqEx+hsLqY9QETEOMdnWdGevgqyS77kF2H7ws6WP20AJJGkFmQyU1kXpu61qwnpCSAR7rQQr8i0I8nRgaimnONzq83SmzIlQF7LLYCPVQQfw/K8nmIvcYvWwOn/vSPR/bum4w6KYrZr6jIQ/6fDYGZ09Pc9jKB6HAI/g+d1O6C8VSzynu8WaHmYcLv4sfFfUyGeO6YFfPhxcZUzqto3j2zXbW4qtV+VETsH/mCzEltFcwXaza6XuCoiwM3+4OtXKPDbxAHwW9cWDRfC3T/7LWOooguVVHGh5inB5t+X80JTR15uA/5kQYSXihiahVsLhUurLg4g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab0303b-cac2-4dfe-620f-08d84056736f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2020 13:32:12.0180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Eg/3OBimhlYhlKVoYjSTqtzfkY4W1heQTfMZZpuWASj7+E5Bp+31VBopKDt8SEbIm7Ag9p/nsSbpcG0eK7s3WzHrs/gXcDDiiCFWxloJ1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0923
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Friday, August 14, 2020 2:44 AM
>=20
> On Thu, Aug 13, 2020 at 04:51:19PM -0700, Michael Kelley wrote:
> > On ARM64, Hyper-V now specifies the interrupt to be used by VMbus
> > in the ACPI DSDT.  This information is not used on x86 because the
> > interrupt vector must be hardcoded.  But update the generic
> > VMbus driver to do the parsing and pass the information to the
> > architecture specific code that sets up the Linux IRQ.  Update
> > consumers of the interrupt to get it from an architecture specific
> > function.
> >
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> >  arch/x86/include/asm/mshyperv.h |  1 +
> >  arch/x86/kernel/cpu/mshyperv.c  |  3 ++-
> >  drivers/hv/hv.c                 |  2 +-
> >  drivers/hv/vmbus_drv.c          | 30 +++++++++++++++++++++++++++---
> >  include/asm-generic/mshyperv.h  |  4 +++-
> >  5 files changed, 34 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/msh=
yperv.h
> > index 4f77b8f..ffc2899 100644
> > --- a/arch/x86/include/asm/mshyperv.h
> > +++ b/arch/x86/include/asm/mshyperv.h
> > @@ -54,6 +54,7 @@ typedef int (*hyperv_fill_flush_list_func)(
> >  #define hv_enable_vdso_clocksource() \
> >  	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
> >  #define hv_get_raw_timer() rdtsc_ordered()
> > +#define hv_get_vector() HYPERVISOR_CALLBACK_VECTOR
> >
> >  /*
> >   * Reference to pv_ops must be inline so objtool
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyp=
erv.c
> > index 3112544..538aa87 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -55,9 +55,10 @@
> >  	set_irq_regs(old_regs);
> >  }
> >
> > -void hv_setup_vmbus_irq(void (*handler)(void))
> > +int hv_setup_vmbus_irq(int irq, void (*handler)(void))
> >  {
>=20
> irq is not used here. Did you perhaps forget to commit a chunk of code?

No, this is correct.  Per the commit message, the irq information
parsed from the DSDT is not used in the x86 code.  But it is used on the
ARM64 side.  I should add a comment to that effect here in the x86
code so there's no confusion.

Michael

>=20
> >  	vmbus_handler =3D handler;
> > +	return 0;
> >  }
>=20
> Wei.
