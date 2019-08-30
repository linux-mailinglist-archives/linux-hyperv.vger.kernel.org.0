Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB07A4116
	for <lists+linux-hyperv@lfdr.de>; Sat, 31 Aug 2019 01:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfH3XhQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 30 Aug 2019 19:37:16 -0400
Received: from mail-eopbgr1310095.outbound.protection.outlook.com ([40.107.131.95]:58170
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728217AbfH3XhQ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 30 Aug 2019 19:37:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcQhqN7PyQIsshSA8boyZld0CbnD29LOQENhXOhdVgIvAVh3nxCPRUvBc3cQYZB1mzUIAy6UI+a9BVXNPc6AARHvC1hvVE0GkNs2ZbxHn+VWmXEWh+WoUvdeZC+ddIYxivUkm45+QtOz1GbGY3JN76SadRP8aznTg+ltVDvZk5S2EqgZXfIRL2UMgs6YhSxvc6/oiyIeko+qATQ2vMqTcY39zOOkmtn4VkFontbAR7zRIbxbRyHIjB7+eK76TXLxOEHnUESSsK2GeZMdpm3S9bPpBRhqGaRzyyCICYQ+dzXzFo/qb6QmeNbHNqJmH8T9DbjxGbNPTF5zREdNhNuZLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+FOjMBVBkLxAtBvWvCYoUX/DXubYULb7vnCcbdPH8k=;
 b=ky/+KzOtZSKH34m5GggN6Rfa08d4gHjn27cjg51CYao9fAl+ukOmXizKI1hpUiskPmLLiBFBxVpjLe4vCXEyckh588IneGBZayYpDwv6pVXBru1bR0UCzvXrwbZkpHxVE7SzBLIcLgD4onwI0xWXf6HfM2SHFAhc85biBiwjPMuOvdUZU0uemdjbV30qmPukwl0x9AGUNozO3ndA3DD7bDDgX5+KB4PQkQ1zNSYDs18kTm31Z1qsgkP9ZLhOkEDQshRWX1DF+L7Nkq2/5mcDqCBVfJgLcznT+Tfk4urLfockSZmh2zWfkypREmzuip8OmxrT8kNrrbW2yZMbwFS23w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+FOjMBVBkLxAtBvWvCYoUX/DXubYULb7vnCcbdPH8k=;
 b=NT026+qdwXI/+m3sxLJkeo+rzfPKJ/RtUKAN+uVz0jbafzlrloLQAjg+JWsgnsrghw0JzIqKYcotAiqu27fl4uWXjdGY42L3zypFqz3cYGqZbfr48wtBJcx/V3tbC1lBB8rPv8gOIP/Nh+Mu6fmqGfOafQZ950v7lGT70RtpIo0=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0140.APCP153.PROD.OUTLOOK.COM (10.170.188.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.2; Fri, 30 Aug 2019 23:37:07 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3%4]) with mapi id 15.20.2241.006; Fri, 30 Aug 2019
 23:37:07 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
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
Thread-Index: AQHVVvnbeUNjfG6a0EKsx3hMtEEAZKcJJ23ggAsvpbA=
Date:   Fri, 30 Aug 2019 23:37:07 +0000
Message-ID: <PU1P153MB0169492C8723AA3CD650A8EEBFBD0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1566265863-21252-1-git-send-email-decui@microsoft.com>
 <1566265863-21252-3-git-send-email-decui@microsoft.com>
 <DM5PR21MB0137A7EC5E51EAF8A0667359D7A40@DM5PR21MB0137.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR21MB0137A7EC5E51EAF8A0667359D7A40@DM5PR21MB0137.namprd21.prod.outlook.com>
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
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [131.107.159.158]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20937a5b-19c3-4d79-c508-08d72da2f8a4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0140;
x-ms-traffictypediagnostic: PU1P153MB0140:|PU1P153MB0140:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB0140BC81CC0FEED6D4DC6912BFBD0@PU1P153MB0140.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(54534003)(199004)(189003)(99286004)(2501003)(316002)(14454004)(14444005)(22452003)(5660300002)(2906002)(110136005)(6116002)(3846002)(53936002)(256004)(8936002)(52536014)(81166006)(8990500004)(66066001)(102836004)(8676002)(81156014)(1511001)(7736002)(25786009)(476003)(305945005)(2201001)(6246003)(486006)(6436002)(10290500003)(71200400001)(55016002)(186003)(76116006)(6506007)(11346002)(76176011)(66446008)(66946007)(229853002)(66556008)(66476007)(64756008)(26005)(7696005)(10090500001)(478600001)(74316002)(446003)(9686003)(4326008)(71190400001)(33656002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0140;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Grfs/hzCRY+pYImy9FuP1WL21+wzS5mKBlRYJFO/IXZSLYIh8UvzF4tLhEn01ErLj/wdJi1vaVHWRFNDL0Rp1KEB0NIK74baUE0c1Kq7Lqb/2F82R2HQYTy/bTC6+WTYLYdac66TlnwqdFHGTtGfD8iFcrSbw9L3lt2KvVk2UWr0V+ogIYPQL1PsNRvjRahHw20VAo//okAbWCgq7t97ilLFUpdjNbEUX6ck27elkYd71Nkmjc7N85hqlQuKzyt2lJBRZALcPMgMDSCsf1quPNliuJ1C4KiCFDxo+FIMYi9PbOtp2GSmrUv9Y/8nV30gThxsFxaRmSshBOmO6fjWgdXb0Ptue/aF4sZTPFnB9aYA4kCljigRD7ufaK+L4LCywB/4IDIGv3In4235T6CUwoXbDnZ0A9H+mB9ao+MOMxc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20937a5b-19c3-4d79-c508-08d72da2f8a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 23:37:07.1326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hKBiem01yK75hmGljzDeT5TU++o+TelnIHMBR+iddVbEwnn470ENEStYg/AD0zniVPYc8DIUvTl+9GHet+IeHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0140
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Friday, August 23, 2019 12:50 PM
>=20
> From: Dexuan Cui <decui@microsoft.com> Sent: August 19, 2019 6:52 PM
> >
> > When a Linux VM runs on Hyper-V and hibernates, it must disable the
> > memory hot-add/remove and balloon up/down capabilities in the hv_balloo=
n
> > driver.
>=20
> I'm unclear on the above statement.  I think the requirement is that
> ballooning must not be active when hibernation is initiated.  Is hibernat=
ion
> blocked in that case?  If not, what happens?

Ballooning (and hot-addition of memory) must not be active if the user
wants the Linux VM to support hibernation, not just when hibernation is
initiated. This is because ballooning and hot-addition of memory are
incompatible with hibernation according to Hyper-V team, e.g. upon
hibernation the balloon VSP doesn't save any info about ballooned-out
pages (if any), so after Linux resumes, Linux balloon VSC expects that the
VSP will return the pages if Linux is under memory pressure, but the VSP
will never return the pages, since the VSP thinks it never stole the
pages from the VM.

So, if the user wants Linux VM to support hibernation, Linux must completel=
y
forbid ballooning and hot-addition of memory, and hence the only
functionality of balloon VSC is reporting the memory pressure to the host.

Ideally, when Linux detects that the user wants it to support hibernation,
the balloon VSC should tell the VSP that it does not support ballooning and
hot-addition; however, the current version of the VSP requires
the VSC should support these capabilities, otherwise the capability negotia=
tion
fails and the VSC can not load at all, so in my changes to the VSC driver, =
I
still report to the VSP that Linux supports the capabilities, but the VSC
ignores the host's requests of balloon up/down and hot add, and returns an
error to the VSP, when applicable.

BTW, in the future the balloon VSP driver will allow the VSC to not support
the capabilities of balloon up/down and hot add.

The remaining problem is: how can Linux know the user wants Linux VM
to support hibernation?

The ACPI S4 state is not a must for hibernation to work, because Linux is
able to hibernate as long as the system can shut down.

My decision is that: we artificially use the presence of the virtual
ACPI S4 state as the indicator of the user's intent of using hibernation.
BTW, I believe the Windows team made the same decision.

Once all the vmbus and VSC patches are accepted, I'll submit a patch to
forbid hibernation if the virtual ACPI S4 state is absent, e.g.
hv_is_hibernation_supported() is false.

> > By default, Hyper-V does not enable the virtual ACPI S4 state for a VM;
> > on recent Hyper-V hosts, the administrator is able to enable the virtua=
l
> > ACPI S4 state for a VM, so we hope to use the presence of the virtual A=
CPI
>=20
> "we hope" sounds very indefinite. :-(    Does ACPI S4 have to be enabled =
for
> hibernation to be initiated?  Goes back to my first question ....

Technically, we don't have to enable ACPI S4, but in practice, as I mention=
ed,
I'll submit a patch to forbid hibernation if ACPI S4 is absent.

>=20
> > S4 state as a hint for hv_balloon to disable the aforementioned
> > capabilities.
> >
> > The new API will be used by hv_balloon.

I'll add my above explanation into the changelog in v4.

Thanks,
-- Dexuan
