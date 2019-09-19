Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E121BB7332
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Sep 2019 08:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387631AbfISGep (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Sep 2019 02:34:45 -0400
Received: from mail-eopbgr1320093.outbound.protection.outlook.com ([40.107.132.93]:34400
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387712AbfISGep (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Sep 2019 02:34:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmAQXEwKkXqI3xml4sqy6ZR5uhWdx59X1teENJF2AlXGt8rOtgs7YSl1Zuxj7QG9nDLyYFbPOz7Sjj86taPzYsxgUw7JIWPCied2W9AUDNJiDrRWZmPBlqwb+AAbIIFxyM7tfGNKsFqB4E8vC5Y3xuL/8SGa/QaRz4wyjQL77CXEKtvJEre78+t16b90n/lOvdaVyb7+hLAOxvOAszKt94orUXj+A29dUc8oKlST2f0dz8Z6LPUDfTBQ7Jm+18AE+D5HkeU7loftgfyvNx4VE6YIkhCZX3nwpexpHK5NqtK8mBqPfGd1L/W4pd+1RBGRWOC1iOAjMu0SfDFd5S8J8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FXHBxNxfmedAbAaXhINI3JwZbPlcBqH0msBTCSwIQM=;
 b=ogUZzg1lgNMQzfNCikxf7Y9gvXCE0fgiN2Ry/fwVQpVPdVNVHcnTtXQDkdbps2omJUgkLky674TwgIepSRAO+FPTRXcJYDc/ehZhmxAmPCGCwo9MLCbCUqoxeaA6Y3Lqlo4PYNmbL+glC1Qbr3agwhpPm72lTAKA7HpbQAocRu5RdItTMWLYei8kl1iU+rHS28ZvEy0FU6AG3NTWPc/V1tFE7aDKrNDwgd+tuX1cmXmpWWbePXU1gKR+P0pqJkV3M11MM9ETHdCJcUUiwlymb0UJsbN/CXPuQiHcKoXOVKZTs2/nm68w5mi/ANOGObULkRRW3WutRBFUGtaJlEE07A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FXHBxNxfmedAbAaXhINI3JwZbPlcBqH0msBTCSwIQM=;
 b=fQTVKgKNiQQ522dWuSwfM9BTdJNBbHEqvyYxHZZYLywvotXeIWoF8OWvbANmqYwBGUDVXOiWWCL5v5nX+g6OCTecaFPV9giCVbgglDgS95GCMIeuROZb+Aebpm/lTBzeP1nBFDBtFPbsN36uRcE7/Z5gzrugeRbYd3KMPp+b+ok=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0201.APCP153.PROD.OUTLOOK.COM (10.170.190.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.3; Thu, 19 Sep 2019 06:34:29 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%8]) with mapi id 15.20.2305.000; Thu, 19 Sep 2019
 06:34:29 +0000
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
Thread-Index: AQHVaYhA3nfAp6qkREmtH6p7KQYwRKcpxtlAgAQ8TICABIF7gA==
Date:   Thu, 19 Sep 2019 06:34:28 +0000
Message-ID: <PU1P153MB01694ABFED7ADAE8B40A65F7BF890@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568245130-70712-1-git-send-email-decui@microsoft.com>
 <1568245130-70712-2-git-send-email-decui@microsoft.com>
 <877e6dcvzj.fsf@vitty.brq.redhat.com>
 <PU1P153MB0169C6B4A78787930CC9ED4FBFB30@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <87pnk0bpe8.fsf@vitty.brq.redhat.com>
In-Reply-To: <87pnk0bpe8.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-19T06:34:26.9630589Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7f9db46b-0a7d-45ba-83da-fab6287ba5b3;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:9da0:245f:bd15:5f6a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01db3f18-9d17-4b54-dfdd-08d73ccb6c7c
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0201:|PU1P153MB0201:|PU1P153MB0201:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB02013E067971254592090982BF890@PU1P153MB0201.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(189003)(199004)(14454004)(14444005)(55016002)(99286004)(71200400001)(71190400001)(8990500004)(5660300002)(229853002)(256004)(86362001)(25786009)(10290500003)(6116002)(10090500001)(4326008)(478600001)(2906002)(22452003)(8936002)(6506007)(7696005)(76116006)(8676002)(11346002)(54906003)(66556008)(33656002)(66446008)(6246003)(186003)(64756008)(66476007)(66946007)(7736002)(305945005)(46003)(102836004)(107886003)(74316002)(446003)(6916009)(476003)(316002)(9686003)(76176011)(81156014)(486006)(81166006)(52536014)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0201;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xI6P5ELuWDVt8C3YgiLS6GMEhvdHBCEkRdOS6j4Kf/DpSDYXYlQKimRTJWkAY2fbB5eKu2LWRfeVAz/WDCz426w1a2Sa/wZ43as3fs6mxZ10QwOQOaIEN4C249JpTdZRdfs8CFPdMEMT0+ptyz/IA1n4eDWY8fwRK1TQ2YQgIr/LEhZvZeuxkIe/ILgtDOT3w1lCuJiVuhFapfceJ4gQEzunicDm1Od2D6qCKrmtC1PsLhoppyrplG5Cg5wBG3kErxi7Rhx7vipTuPjzyMErTaZ53ZyGoXuer8PueGJS6jY23dHdiW16UYwUKZaPSCq4PR4yyzrpmnZZLXXFkXZ0hP9pxBDo7mbzPiUg/Co5y4h0nRFX+nvyBKGB9Tc/kP3LRd3Aymy/kapdjfafKKQNIh+UgquBrlxVYzIR5otsqk0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01db3f18-9d17-4b54-dfdd-08d73ccb6c7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 06:34:28.8167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nag239h7zC0I2b+yqmQ45XSq6Z+00t2j1IHH1e7sxsIraYIdfo/PtKeK9gxKR8eA9ZOEIFOGTtV/D08QPA0jlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0201
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> Sent: Monday, September 16, 2019 1:46 AM
> Dexuan Cui <decui@microsoft.com> writes:
>=20
> >> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> >> Sent: Thursday, September 12, 2019 9:37 AM
> >
> >> > +static int util_suspend(struct hv_device *dev)
> >> > +{
> >> > +	struct hv_util_service *srv =3D hv_get_drvdata(dev);
> >> > +
> >> > +	if (srv->util_cancel_work)
> >> > +		srv->util_cancel_work();
> >> > +
> >> > +	vmbus_close(dev->channel);
> >>
> >> And what happens if you receive a real reply from userspace after you
> >> close the channel? You've only cancelled timeout work so the driver
> >> will not try to reply by itself but this doesn't mean we won't try to
> >> write to the channel on legitimate replies from daemons.
> >>
> >> I think you need to block all userspace requests (hang in kernel until
> >> util_resume()).
> >>
> >> While I'm not sure we can't get away without it but I'd suggest we add=
 a
> >> new HVUTIL_SUSPENDED state to the hvutil state machine.
> >> Vitaly
> >
> > When we reach util_suspend(), all the userspace processes have been
> > frozen: see kernel/power/hibernate.c: hibernate() -> freeze_processes()=
,
> > so here we can not receive a reply from the userspace daemon.
> >
>=20
> Let's add a WARN() or something then as if this ever happens this is
> going to be realy tricky to catch.

Looking at the path hibernate() -> freeze_processes() ->=20
try_to_freeze_tasks(true) -> freeze_task() -> fake_signal_wake_up(), I'm
sure when try_to_freeze_tasks(true) returns 0, all the user-space processes
must be frozen in do_signal() -> get_signal() -> try_to_freeze() -> ... ->=
=20
__refrigerator().

hibernate () -> hibernation_snapshot () -> dpm_suspend() -> ... ->=20
util_suspend() only runs after hibernate() -> freeze_processes(), so I'm
pretty sure we're safe here.

> > However, it looks there is indeed some tricky corner cases we need to d=
eal
> > with: in util_resume(), before we call vmbus_open(), all the userspace
> > processes are still frozen, and the userspace daemon (e.g. hv_kvp_daemo=
n)
> > can be in any of these states:
> >
> > 1. the driver has not buffered any message for the daemon. This is good=
.
> >
> > 2. the driver has buffered a message for the daemon, and
> > kvp_transaction.state is HVUTIL_USERSPACE_REQ. Later, the kvp daemon
> > writes the response to the driver, and in kvp_on_msg()
> > kvp_transaction.state is moved to HVUTIL_USERSPACE_RECV, but since
> > cancel_delayed_work_sync(&kvp_timeout_work) is false (the work has
> > been cancelled by util_suspend()), the driver reports nothing to the ho=
st,
> > which is good as the VM has undergone a hibernation event and IMO the
> > response may be stale and I believe the host is not expecting this
> > response from the VM at all (the host side application that requested t=
he
> > KVP must have failed or timed out), but the bad thing is: the "state"
> > remains in HVUTIL_USERSPACE_RECV, preventing
> > hv_kvp_onchannelcallback() from reading from the channel ringbuffer.
> >
> > I suggest we work around this race condition by the below patch:
> >
> > --- a/drivers/hv/hv_kvp.c
> > +++ b/drivers/hv/hv_kvp.c
> > @@ -250,8 +250,8 @@ static int kvp_on_msg(void *msg, int len)
> >          */
> >         if (cancel_delayed_work_sync(&kvp_timeout_work)) {
> >                 kvp_respond_to_host(message, error);
> > -               hv_poll_channel(kvp_transaction.recv_channel,
> kvp_poll_wrapper);
> >         }
> > +       hv_poll_channel(kvp_transaction.recv_channel, kvp_poll_wrapper)=
;
> >
> >         return 0;
> >  }
> >
> > How do you like this?
> >
>=20
> Is it safe to call hv_poll_channel() simultaneously on several CPUs? It
> seems it is as we're doing
>=20
> smp_call_function_single(channel->target_cpu, cb, channel, true);

Looks safe to me. The code has been there for years. :-)
=20
> (I'm asking because if it's not, than doing what you suggest will open
> the following window: timeout function kvp_timeout_func() is already
> running but the daemon is trying to reply at the same moment).
>=20
> > I can imagine there is still a small chance that the state machine can =
run
> > out of order, and the kvp daemon may exit due to the return values of
> > read()/write() being -EINVAL, but the chance should be small enough in
> > practice, and IMO the issue even exists in the current code when
> > hibernation is not involved, e.g. kvp_timeout_func() and kvp_on_msg()
> > can run concurrently; if kvp_on_msg() runs slowly due to some reason
> > (e.g. the kvp daemon is stopped as I'm gdb'ing it), kvp_timeout_func()
> > fires and moves the state to HVUTIL_READY; later kvp_on_msg() starts
> > to run and returns -EINVAL, and the kvp daemon will exit().
> >
> > IMHO here it looks extremely difficult to make things flawless (if that=
's
> > even possible), so it's necessary to ask the daemons to auto-restart on=
ce
> > they exit() unexpectedly. This can be achieved by configuring systemd
> > properly for the kvp/vss/fcopy services.
>=20
> I think we can also teach daemons to ignore -EINVAL or switch to
> something like -EAGAIN in non-fatal cases.

Maybe the driver should return 0 rather than -EINVAL for the kvp daemon
in some scenarios, since kvp is never 100% reliable.

> > I'm not sure introducing a HVUTIL_SUSPENDED state would solve all
> > of the corner cases, but I'm sure that would further complicate the
> > current code, at least to me. :-)
> >
>=20
> Maybe, if we don't need it than we don't. Basically, I see the only
> advantage in having such state: it makes our tricks to support
> hibernation more visible in the code.
> Vitaly

Let me think about this.=20

BTW, for vss, maybe the VM should not hibernate if there is a backup=20
ongoing? -- if the file system is frozen by hv_vss_daemon, and the VM
hibernates, then when the VM resumes back, it's almost always true that=20
the VM won't receive the host's VSS_OP_THAW request, and the VM will
end up in an unusable state.

Thanks,
-- Dexuan

