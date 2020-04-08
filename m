Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A08841A280E
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Apr 2020 19:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgDHRnm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 8 Apr 2020 13:43:42 -0400
Received: from mail-eopbgr1300112.outbound.protection.outlook.com ([40.107.130.112]:5460
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727028AbgDHRnl (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 Apr 2020 13:43:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlZUIJZSB0nG5B+fbWjtJCSG1Yt98oZJgHZPOcV4tSWjucyNeW/6rFBpYiZU8sdm7bMn6I7XoroeDUIl84rSaOdsqxvMeE+C6TAQHV8eLJZUOvgFlc6QR9gALz3fBvv4bxCrwVpuZQ19W5LNM+/joExsmd9RFf7MfzJSqwikWbNpRrUYsYahxeEfpEPki5V6B7iTXQ49vfx2MOuvH4BvjRMjASyUmJr2Y5Z4F8m0q5mpUpVf84W6ID0Y1ZfgfQt/H3khsUKbTW8ffkmo8Q2VKnIxwphNvor06eHE/dVhNSnKTu98Hz8pStSOto5bvzxInftcd4OP5tmNtehzTETn1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKFkx8NFnofuREKm4Em9qiCq5+0kqo8XyjRmgHka6bc=;
 b=iFFLqe25RE/E+dhhFsx4+8lYeI+hCBDh7yq01W/D1ijtFhJW4BILbcygDZhoQV+NBAnWdd8I9XYL/gtDDc8RMg6kTc4BijNJRicG41M6x9urFvMVqqS3NAG2e58Tff8vq+xJZOXbEyEg0YBv148OZYCkJKNRmUiqGTAu/711P9GW7LevqLBZUJIy+HK2GX96tdGnPD7QgyOeQx+3RQYdV0qhZih2qLjYjqQZvhKz95+cAixX2MVotrfqEnkdYZLBXH+6tDkOcCa2eb1tJkxP/2EYBDSuwNPWPiuZxF+84TFZtBRZGR/Gf9UiDOC6Qpkquyxx82M5luyJv7fmLCOmEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKFkx8NFnofuREKm4Em9qiCq5+0kqo8XyjRmgHka6bc=;
 b=ik11uLT8yjY10jksJg21k4abUg/NSA2UAyScWyRf7SotUHbYmtBlGJBoTSDfsn6K1kOFjWA0JYt2vGU+t95A0n4ogoa7sWWEi0VIqgIkVNWoiRFUuwOKpwE3yjLffH9gV3/N/63qJCrqszvKbq7TZLBHBep2R8iK4kqWaG3tgPg=
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM (52.132.236.76) by
 HK0P153MB0337.APCP153.PROD.OUTLOOK.COM (52.132.237.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.4; Wed, 8 Apr 2020 17:43:35 +0000
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a]) by HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a%2]) with mapi id 15.20.2921.009; Wed, 8 Apr 2020
 17:43:35 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: Disallow the freeze PM operation
Thread-Topic: [PATCH] Drivers: hv: vmbus: Disallow the freeze PM operation
Thread-Index: AQHWDb0CzRPAkatwXES7XuIgEFDFbKhvenBA
Date:   Wed, 8 Apr 2020 17:43:35 +0000
Message-ID: <HK0P153MB02732CCBDFA879FCE5CA48C7BFC00@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
References: <1586296907-53744-1-git-send-email-decui@microsoft.com>
 <877dyq2d4p.fsf@vitty.brq.redhat.com>
In-Reply-To: <877dyq2d4p.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-08T17:43:31.6238527Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9df5e1a5-a3b7-4982-a7a0-1af096e5b2e6;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:25f2:87c1:762f:53ac]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8aa7f46-c832-4dad-f3c6-08d7dbe45d09
x-ms-traffictypediagnostic: HK0P153MB0337:|HK0P153MB0337:|HK0P153MB0337:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB033792928250E1763C4DF25FBFC00@HK0P153MB0337.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0P153MB0273.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(82960400001)(2906002)(316002)(6916009)(33656002)(9686003)(10290500003)(86362001)(8676002)(66556008)(66446008)(64756008)(478600001)(66946007)(8936002)(81156014)(107886003)(186003)(76116006)(66476007)(71200400001)(52536014)(4326008)(6506007)(55016002)(82950400001)(54906003)(8990500004)(81166007)(5660300002)(7696005);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qXMJxVcPss8tcmAMIc0YewpM8jOLil1kKQT0yX59qze53guwB7OQIZkMQbw0ec2ewq+SMeXOc1dt68IcnFq51gx89MpFYWlEQNJLCmHPjDTVROJudgZhYOo36b5EudKTHaNHM1rJKvyrYmM7CZuMsTX5ihzFjWCDHWcSaVdvsfkLQBbEUUb4hgfT5k28KB9beOHEhvjSXwte8u1fSGPFJqcOFLdZnB8r29HL2CUlwBRfFSkJi284ujKrjMPkoyRYFRwltwCKRXOHCqNa1/2HmYKiAqbFQbVnaxwdgt6K+uYwCmeaCJm3e5Ffyf56a/X4t2fl5G/CS7CFYjwsBRTWrAvoFfVChWayoPffWT9Xep9T5KoTo+fySHOK1nSzLDrCkUQkPBUPhm8PcvA8mli2alSrWa6Bc1lx4Ga3p21sXJiieDuDg5GgjBA1gOUylaee
x-ms-exchange-antispam-messagedata: LBI2+xDw04rQm2us3C1mj2SWadPBdEU9O6S30r+Nqoe8B/b7/tBTUNVICx5+2iNj8tMZA8YtQtwh7wZmv4w1iHI1l3H2aI4/Jg1PDNqYFbq9aoj+TH8WWeoYG2+B3VHVBJoLGcAvoLI0R/B2aU4d4MMK92GXB4ufWsMcLgBDM7gDY31UWZMQlOPYfHkVV0vX60vl1CzCbKBd0MZ5CNNI1g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8aa7f46-c832-4dad-f3c6-08d7dbe45d09
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 17:43:35.1826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7hJ6sMlW0jgfMqleL4GFRS+zy/PtYF2op5pO+1wfllWTLxAIHpkbscFf4qLHdmRkOaezGo27Iod4qqXd5q4WSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0337
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> Sent: Wednesday, April 8, 2020 8:47 AM
> > IMO 'freeze' in a Linux VM on Hyper-V is not really useful in practice,
> > so let's disallow the operation for both Gen-1 and Gen-2 VMs, even if
> > it's not an issue for Gen-1 VMs.
>=20
> Suspend-to-idle may not be very useful indeed, however, it worked before
> and I think we can just fix it.

How can we fix Suspend-to-idle for a Gen-2 VM, in which no device can work
as wakeup devices? Note: in the case of Suspend-to-idle, now all the vmbus
devices including the synthetic keyboard/mouse are suspended completely.

Are you suggesting hv_vmbus should distinguish Suspend-to-idle from
hibernation, and for the former hv_vmbus should not suspend the synthetic
keyboard/mouse? This should be doable but IMO this is not a very trivial
effort, and I'm trying to avoid it since IMO Suspend-to-idle is not really=
=20
useful in practice for a Linux VM on Hyper-V. :-)

> In particular, why do we need to do
> anything when we are not hibernating?

Are you suggesting hv_vmbus should not suspend the vmbus devices at all
in the case of Suspend-to-idle?

> > +/*
> > + * Note: "freeze/suspend" here means "systemctl suspend".
> > + * "systemctl hibernate" is still supported.
>=20
> Let's not use systemd terminology in kernel, let's use the ones from
> admin-guide/pm/sleep-states.rst (Suspend-to-Idle/Standby/Suspend-to-RAM/
> Hibernation).
> --
> Vitaly

Thanks! I'll use the accurate terms.

Thanks,
-- Dexuan
