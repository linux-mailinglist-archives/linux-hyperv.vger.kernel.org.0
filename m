Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233F31AE8B1
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Apr 2020 01:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgDQXrx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Apr 2020 19:47:53 -0400
Received: from mail-eopbgr1320093.outbound.protection.outlook.com ([40.107.132.93]:21811
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726036AbgDQXrw (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Apr 2020 19:47:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2KKHat2tcjJgChp8RvZTAdvQfVUjJ6O7zwGjQvZMVThK/q8YUwGZ3zQbERKs9K341FDenMhcugJ9iHTg+VYJ6a5AcvvL6lw7R3CHu7k+GH2Iob4pGwgRQLoVIoLUfIuq3OZrdjfSwAjdyAr6sbYGCUWAaceQcr8mAWG99XEdlNtos0fGDT0LF3HgngoWSARyphIUaenxb4GcBSHQJ2JYH8ociWPf3l13gssXdaamJeSJVYUt+ZseY/v+0nxazPfOUIyf7mLlr2ckMnOWI08ZNiKi/TQJUvrJH0xRohEwx/wpdKqa95c72Og+Ai72YR1SEra8soZjFrBDqjnKtrlJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7du3dsBit6gpKRKdQ1Xqzs3L/R02H1ieS+Q3fPbuKHk=;
 b=mzyUM+uw/SIUqFW99RgmrVcn+eDDkZbfQkvIg2YnkdgYJLi9dlK6hkB8VaCyiAaDcJTb+Vmd2W5WUorder9VC0EsAg6CRAp+XSXvOu9VwCXK9R6X1+l9nt83+vE82Q2CfYXweNMe6skGaDRhFN+car78sAOC3tSu63mgxhTXKMlbJp90SuTISQGYX7UWZnynbsomkJsacxYsf/dS6pbBRRWcbOtd/HXG3En33gX6KWKNUrKV3AXqndrXk1/0OUmFwPIyxl1Sp5kOBxPzvV2RCTu4NwIMiyufCiMwylAxcrWXTzhDUSN+MLDZKQ8UOlv85RIV986o9YjralhvDhUvzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7du3dsBit6gpKRKdQ1Xqzs3L/R02H1ieS+Q3fPbuKHk=;
 b=A/On80byDvlPYW4OHWNlzhHSYSifIK2fe2fEMvUm9bdBLBjwwx2+WhXMhlnAdUYy+eRPG0TpsEZQAyV7SixRngPDm3v0obo0y2I5k03Al3QCvNT9OpktQlhgKQi1YP5K/+J6qg16G/zsHDJPWrmMLFF5I50ATQpE6iFtNvv+kTI=
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM (2603:1096:203:b2::12)
 by HK0P153MB0179.APCP153.PROD.OUTLOOK.COM (2603:1096:203:29::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.3; Fri, 17 Apr
 2020 23:47:42 +0000
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a]) by HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a%2]) with mapi id 15.20.2937.007; Fri, 17 Apr 2020
 23:47:42 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>
CC:     "bp@alien8.de" <bp@alien8.de>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH] x86/hyperv: Suspend/resume the VP assist page for
 hibernation
Thread-Topic: [PATCH] x86/hyperv: Suspend/resume the VP assist page for
 hibernation
Thread-Index: AQHWFRKUfBcacZSsfESBcN86F1My4Q==
Date:   Fri, 17 Apr 2020 23:47:41 +0000
Message-ID: <HK0P153MB0273A04F0585524883C46B0FBFD90@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
References: <1587104999-28927-1-git-send-email-decui@microsoft.com>
 <20200417110007.uzfo6musx2x2suw7@debian>
In-Reply-To: <20200417110007.uzfo6musx2x2suw7@debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-17T23:47:38.2490791Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9425f78a-9b51-488f-bae6-3c0ee39fca53;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:6de6:6792:4d71:47c3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 565586ff-d6a7-4a5e-2118-08d7e329b839
x-ms-traffictypediagnostic: HK0P153MB0179:|HK0P153MB0179:|HK0P153MB0179:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB01799215F5B69E51E4D00B37BFD90@HK0P153MB0179.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0P153MB0273.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(66946007)(6916009)(66476007)(64756008)(52536014)(2906002)(66556008)(8990500004)(66446008)(33656002)(76116006)(82950400001)(5660300002)(86362001)(82960400001)(8676002)(4326008)(8936002)(7696005)(53546011)(186003)(6506007)(54906003)(81156014)(10290500003)(15650500001)(9686003)(55016002)(478600001)(71200400001)(316002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9s2EAeEW/0SvmuZnNBVPaB0IXHegCulMxrM5ZLzly+bmkzbvyEGKSu2J9gm1f0RFE5Ft+awQB1DnHDifUBK0P68ygQ06LJaGVgMSfdVJqmMGYeY/PwKojShhBg/LuhpPyr7yRlwVHFknzLsQr0PTAroRFmTWyb8g5Fm4lARVDTt56h9p0WldQ5/q6lOueBrWK6sX4oHjZG+4TgtcA0ZVfa4B0mPYZpxtwLhNT0d/6Gb++DRynKkRBsYq3W7B/10WVt38CZMIeKtxqQXX6EXPyTSYcARsNJK5Yeh1B7h/71Mx7pOonvXIIXc020XDIwtO5tfiLEP0OYQAIp49yqigdxeeboUdaCQFoB0q0CwaffNRMJEMK7QJ4BzePmiblTVw0koU9bgl5DIcA/jRpzvJfWp7j83mrmx1B/WCkEXVEH4EPdNwqaNXieMmyhO4T6Vw
x-ms-exchange-antispam-messagedata: CUXzUVh4EG0bgOLE5Vin/DEos0OJSH/GU1YmHtwd1bHjzwNWOtMVlUEHjafuziQTYhFbMt+LY6rfdVd+eSSxS9stee2pB1qLEYx1bBsjZUHlKNdqoFjTpsBKqSK5VfSyinb+Q0dxKTyRYN2EVGJkmTge1uu4LcoVa4hdMA3twWydpbHvrX/frBpvLWfV+zEjgp9y9JSofV0dW/D+uOJTE9bOdI8SoNZI+/hfWdhwrJIUXP41N7AyxpLudKGGUL1tcNlnASHG9RjgV36dE7f91swC+LIYYX0nqJocdIi+WdBdsvE1jAoAkhqHyLY9r9EgeBsCA/ck8GeEfsZ/Y0bywb6xHGfQWkL5vnTsofV8PdwyRkX9RuDn9k2DEqbY+ubmJTsF3gL83C23/KWWjOeJGQOAZ5UN+DTTw9hLhoc1YQwRwkfcw+6cxi/qGmcCPTUg3ofdVR8VX5Tza6Elm/WaDhLlv/LZtARTV2SiANFlH2BhaBZBGoTKXA55vP0xmZ5PPs9x/NJlXVp99zXT9czqAWiyxHdXlcLaOgiIEzV9CVpvXQ2IUkFv7jb6pp6nCigOTUbaIkplwKh0sLpIDXOVrypG7aYiB+MvmaS98n5+aTvtFnqOgMrd6yLx4KrozA2m0Ks/tOVfMwcYXpH/55qPbIg2fNpR4XnqYqZOyfHsU8Mv9YvdsNzd/3SOVdw9N1SXQ8We8/l8Xcx9hvfzw6C9WUoDly7AlkicW5izyU/aqJyGJ+6kf1+eveQpzfibn+NX9mcfpqGAfU1OcdYqy9cvJb6yNBQWeGGpv0/tA9+j4FZwQ5nONoZm0mamxUlXaqnFK9ke8IzP1jrTvdWSjqOYEjw9UMQaCAu7WXkeWjy5cq4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565586ff-d6a7-4a5e-2118-08d7e329b839
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 23:47:41.5603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: za1MklIXp2t/tI6ujwOz0pq89P8D7rhyWAtQ0R4/hoRVeq7Zfx4NtSBiqMo2qO+rq/XbL4EJcSaOd86CGSm2yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0179
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Wei Liu <wei.liu@kernel.org>
> Sent: Friday, April 17, 2020 4:00 AM
> To: Dexuan Cui <decui@microsoft.com>
>=20
> On Thu, Apr 16, 2020 at 11:29:59PM -0700, Dexuan Cui wrote:
> > Unlike the other CPUs, CPU0 is never offlined during hibernation. So in=
 the
> > resume path, the "new" kernel's VP assist page is not suspended (i.e.
> > disabled), and later when we jump to the "old" kernel, the page is not
> > properly re-enabled for CPU0 with the allocated page from the old kerne=
l.
> >
> > So far, the VP assist page is only used by hv_apic_eoi_write(). When th=
e
> > page is not properly re-enabled, hvp->apic_assist is always 0, so the
> > HV_X64_MSR_EOI MSR is always written. This is not ideal with respect to
> > performance, but Hyper-V can still correctly handle this.
> >
> > The issue is: the hypervisor can corrupt the old kernel memory, and hen=
ce
> > sometimes cause unexpected behaviors, e.g. when the old kernel's non-bo=
ot
> > CPUs are being onlined in the resume path, the VM can hang or be killed
> > due to virtual triple fault.
>=20
> I don't quite follow here.
>=20
> The first sentence is rather alarming -- why would Hyper-V corrupt
> guest's memory (kernel or not)?

Without this patch, after the VM resumes from hibernation, the hypervisor=20
still thinks the assist page of vCPU0 points to the physical page allocated=
 by
the "new" kernel (the "new" kernel started up freshly, loaded the saved sta=
te=20
of the "old" kernel from disk into memory, and jumped to the "old" kernel),
but the same physical page can be allocated to store something different in
the "old" kernel (which is the currently running kernel, since the VM resum=
ed).

Conceptually, it looks Hyper-V writes into the assist page from time to tim=
e,
e.g. for the EOI optimization. This "corrupts" the page for the "old" kerne=
l.

I'm not absolutely sure if this explains the strange hang issue or triple f=
ault
I occasionally saw in my long-haul hibernation test, but with this patch,
I never reproduce the strange hang/triple fault issue again, so I think thi=
s
patch works.

> Secondly, code below only specifies cpu0. What does it do with non-boot
> cpus on the resume path?
>=20
> Wei.

hyperv_init() registers hv_cpu_init()/hv_cpu_die() to the cpuhp framework:

cpuhp =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/hyperv_init:online",
                       hv_cpu_init, hv_cpu_die);

In the hibernation procedure, the non-boot CPUs are automatically disabled
and reenabled, so hv_cpu_init()/hv_cpu_die() are automatically called for t=
hem,
e.g. in the resume path, see:
    hibernation_restore()
        resume_target_kernel()
            hibernate_resume_nonboot_cpu_disable()
                disable_nonboot_cpus()=20
            syscore_suspend()
                hv_cpu_die(0)  // Added by this patch
            swsusp_arch_resume()
                relocate_restore_code()
                    restore_image()
                        jump to the old kernel and we return from=20
                        the swsusp_arch_suspend() in create_image()
                            syscore_resume()
                                hv_cpu_init(0) // Added by this patch.
                            suspend_enable_secondary_cpus()
                            dpm_resume_start()
                            ...
Thanks,
-- Dexuan
