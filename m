Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4ABB25D8
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Sep 2019 21:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389108AbfIMTPp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 13 Sep 2019 15:15:45 -0400
Received: from mail-eopbgr1310138.outbound.protection.outlook.com ([40.107.131.138]:19072
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388860AbfIMTPp (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 13 Sep 2019 15:15:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SM+ITHUTCV9tFgeW2gPR+4GQLKANSFH6VTfmc7yaFDaUMxOA0iLxmakXt4HssSQEzfo6F0byXWabX+79gwFc/RSsS9LG3qfRFt6Jc6mSrpJfWq8lapY22v4TRCqYWZemI3fCw+nn2fVLQg1684GyoKDOFV+vZP7Vr1LTwL9hTUa/vtwzV5HbB0jnM2l2/rcFdksTUOfbK4tvV7M7FUD+xo5ux9TGx+QLzKgrm9aw/ggsZ6vcZ8YMutTZhKq6mlm7/AUcvFBhyAuC2fMT77ykqD/XoopgSfVqKQQx5b1nsBZwY4G3tQfEubhtG7g6TUlCCsZpjaJT/368oWNH+bKsQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6ea5XuyzDW5OkSmWZIl+meY5RZVFCTiPR6QqTvQDcM=;
 b=dgf/22IUtOEVTGgMVfQADDdJgFD8XCwXGa3jfyejsA8WlPw2XsmOo5FAOWTaiiiZqaisp+Ev9VeUILECn/CeHU3R8Kf3GAUog6UvsscpeWO06/D1ScrS9BOIHePDvWApRLM/p5T3TkD6XuAnlWR7qZYFkTrNUAAViCiNEMFixV1a0aT5mhQ7uUSd4woYSo9tWqMzZSBSm1js4G19vYq9OA2L86Ht5SIa5RsvbyHYNDqLsPz51qHgcjCvfDeySwP2/ZMWEwacjnlzoDT7QB/CbVu0StLyQZgerNTbVKDjvt2UE77Fi7CfI6XfT5dqltjAD3tocB3HBgVLRm5Vtfa5xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6ea5XuyzDW5OkSmWZIl+meY5RZVFCTiPR6QqTvQDcM=;
 b=ZJME8kyNs2yelwlB9BfDH+xPCNZS7bPmQa33//4EFxbAQczioovP4ryUEI4TWYwsbZc7QbkaTOI+nF6PV09e0z2ylBWIaoG6iopYK3IRT//vqoIVo5KFV4ZwNaS2fPbB1QMY3kPeASr7JwOvPUmtGZunlREx1QSx3C6Fz+/jx5s=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0156.APCP153.PROD.OUTLOOK.COM (10.170.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.7; Fri, 13 Sep 2019 19:15:31 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3%4]) with mapi id 15.20.2284.009; Fri, 13 Sep 2019
 19:15:31 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH 1/3] hv_utils: Add the support of hibernation
Thread-Topic: [PATCH 1/3] hv_utils: Add the support of hibernation
Thread-Index: AQHVaYhA3nfAp6qkREmtH6p7KQYwRKcpxtlA
Date:   Fri, 13 Sep 2019 19:15:30 +0000
Message-ID: <PU1P153MB0169C6B4A78787930CC9ED4FBFB30@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568245130-70712-1-git-send-email-decui@microsoft.com>
 <1568245130-70712-2-git-send-email-decui@microsoft.com>
 <877e6dcvzj.fsf@vitty.brq.redhat.com>
In-Reply-To: <877e6dcvzj.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-13T19:15:29.3031284Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=75cdf2d8-472f-448d-80f9-d80df38217ad;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [73.140.237.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d480139c-a409-40b6-d6b4-08d7387ebec0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0156;
x-ms-traffictypediagnostic: PU1P153MB0156:|PU1P153MB0156:|PU1P153MB0156:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0156EE7CFABDF497DBC01913BFB30@PU1P153MB0156.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(189003)(199004)(10090500001)(4326008)(8936002)(66066001)(66446008)(64756008)(66556008)(76116006)(5660300002)(66476007)(305945005)(186003)(66946007)(71190400001)(71200400001)(54906003)(316002)(3846002)(6116002)(7736002)(76176011)(33656002)(99286004)(52536014)(7696005)(6436002)(74316002)(22452003)(11346002)(25786009)(446003)(14444005)(476003)(9686003)(478600001)(10290500003)(256004)(8676002)(14454004)(86362001)(26005)(486006)(6506007)(53936002)(229853002)(102836004)(2906002)(8990500004)(6246003)(107886003)(6916009)(81156014)(81166006)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0156;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3bD8K4YoMjNI8Te5THxq5T0qzNAFFBXDY4Kj+lnQqnWThNqxE2bMRoOn/jAtF/pi9HNbHUVwhxNMc8OxxIq7eUOMnjWJze1YHuNIq9Kd47iSi/1/LUMiETEcjAndz5bt4TbO3kYtXd4kDvFp4iRxFFsfM25tWJ1wfRyXlWuzFZLGypFlpTNl24seuz+jrziH/Ysorlj/eLLYEqcllwGx0eB0s7X0OPqlg/y7qmnDERba0ZyXe7524gamsDdoVVGAq82B3l8Kd2zSYOA1ERolgU0TlErQ6kNwR16+Z7OlPvpESWfOf7j342VZjxkBErHcZ2zMjIOBYb16LnmVJp/3w7s+OU4I9njn/wxhWR0kedr3+T7kbtmx2O/7PPPC+JJ3GWGForKEUOW7F+QXoaK4MfhHMsJwkGFoBvv/RCDVzZs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d480139c-a409-40b6-d6b4-08d7387ebec0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 19:15:30.9890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +hat5Zfz3QLxMLf6VGqsvlKuXo+duEN6zQKomJiqSMa2mc53dfqfOVbm3IGLwcXm1VuzGQPjJebtt0d1Xbp8Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0156
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> Sent: Thursday, September 12, 2019 9:37 AM

> > +static int util_suspend(struct hv_device *dev)
> > +{
> > +	struct hv_util_service *srv =3D hv_get_drvdata(dev);
> > +
> > +	if (srv->util_cancel_work)
> > +		srv->util_cancel_work();
> > +
> > +	vmbus_close(dev->channel);
>=20
> And what happens if you receive a real reply from userspace after you
> close the channel? You've only cancelled timeout work so the driver
> will not try to reply by itself but this doesn't mean we won't try to
> write to the channel on legitimate replies from daemons.
>=20
> I think you need to block all userspace requests (hang in kernel until
> util_resume()).
>=20
> While I'm not sure we can't get away without it but I'd suggest we add a
> new HVUTIL_SUSPENDED state to the hvutil state machine.
> Vitaly

When we reach util_suspend(), all the userspace processes have been
frozen: see kernel/power/hibernate.c: hibernate() -> freeze_processes(),
so here we can not receive a reply from the userspace daemon.

However, it looks there is indeed some tricky corner cases we need to deal
with: in util_resume(), before we call vmbus_open(), all the userspace
processes are still frozen, and the userspace daemon (e.g. hv_kvp_daemon)=20
can be in any of these states:

1. the driver has not buffered any message for the daemon. This is good.

2. the driver has buffered a message for the daemon, and
kvp_transaction.state is HVUTIL_USERSPACE_REQ. Later, the kvp daemon
writes the response to the driver, and in kvp_on_msg()=20
kvp_transaction.state is moved to HVUTIL_USERSPACE_RECV, but since
cancel_delayed_work_sync(&kvp_timeout_work) is false (the work has
been cancelled by util_suspend()), the driver reports nothing to the host,
which is good as the VM has undergone a hibernation event and IMO the
response may be stale and I believe the host is not expecting this=20
response from the VM at all (the host side application that requested the
KVP must have failed or timed out), but the bad thing is: the "state"
remains in HVUTIL_USERSPACE_RECV, preventing
hv_kvp_onchannelcallback() from reading from the channel ringbuffer.

I suggest we work around this race condition by the below patch:

--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -250,8 +250,8 @@ static int kvp_on_msg(void *msg, int len)
         */
        if (cancel_delayed_work_sync(&kvp_timeout_work)) {
                kvp_respond_to_host(message, error);
-               hv_poll_channel(kvp_transaction.recv_channel, kvp_poll_wrap=
per);
        }
+       hv_poll_channel(kvp_transaction.recv_channel, kvp_poll_wrapper);

        return 0;
 }

How do you like this?

I can imagine there is still a small chance that the state machine can run
out of order, and the kvp daemon may exit due to the return values of
read()/write() being -EINVAL, but the chance should be small enough in
practice, and IMO the issue even exists in the current code when
hibernation is not involved, e.g. kvp_timeout_func() and kvp_on_msg()=20
can run concurrently; if kvp_on_msg() runs slowly due to some reason=20
(e.g. the kvp daemon is stopped as I'm gdb'ing it), kvp_timeout_func()
fires and moves the state to HVUTIL_READY; later kvp_on_msg() starts
to run and returns -EINVAL, and the kvp daemon will exit().

IMHO here it looks extremely difficult to make things flawless (if that's
even possible), so it's necessary to ask the daemons to auto-restart once
they exit() unexpectedly. This can be achieved by configuring systemd
properly for the kvp/vss/fcopy services.=20

I'm not sure introducing a HVUTIL_SUSPENDED state would solve all
of the corner cases, but I'm sure that would further complicate the
current code, at least to me. :-)

Please share your thoughts. I believe you know all of these much
better than me, as you're the author of the state machine. :-)

Thanks,
-- Dexuan
