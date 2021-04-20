Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A9F366186
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Apr 2021 23:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbhDTVYo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Apr 2021 17:24:44 -0400
Received: from mail-eopbgr770120.outbound.protection.outlook.com ([40.107.77.120]:45540
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234159AbhDTVYn (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Apr 2021 17:24:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GD5XE//Bxz6ANjQwCh0fEAdMY4DPo/tbecaU6LOjcnSvw4ln4I0nDo1XDjnusS/Lqa7ukN8DTqkLmabf+GYy+PB1lB5I4S1wf7kJb8hhIfxeAjDrC8g5va2paDXKsQxrz8+DSt9jrh6gGXvQmpmcWc+kLdDm+SlFo1kY4RQybCF0KO6UcKuS0rXs/mgHSWBGvAfqnCDIUPMQu+c3XjO+m7YvWA8eADBP3ep15GQlX3FoubXLYMW5SEs13mNwXX/PNswTzLOxACrmmZa3H9v7a2rS0/29SHuJlotDidSY5M4fPTZfnHbzmbw8ktJTPJTzhrhdaK6/Euw4h88fNgCUvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDzpzvGN6WWWIqKye5pRlYDwrTlYMWvCeRK6jStM0O8=;
 b=U03zDngaEi3utdN4i74ZXRkj+ORSAH/pSNZ/fiK72EP7Z+0G1akbxJfhVq70DT0PePysTgGvPsRbEhjmmEik/o12qVZRELUAA6XFjBcSwmKDfC2ZOlRpP+Hnx2XXX+mfnF5Ug2c6DriKKyPd3QoxJ+FkmjkT70qWRMF1bhIcc78h4KRtJeZkPU598LKwJmUytzsmNV71uGzkM691N5azO5UtXIP4F7kX+8F7R55CiHQPsgBBzmcXWXtAKn/Jw7RRBc/eYb77KRtx5kqmrsNWO0Ad+FA1q/W6T5M18/h32yaSRMJq90697rAzKk+XMeXHkFsPpSkcGSNgujm1KiWNPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDzpzvGN6WWWIqKye5pRlYDwrTlYMWvCeRK6jStM0O8=;
 b=iajveSFsLUzdfeMikCQouHUEFcY3xn6XAdjoQU7SNJvKacx2SnAuDcEHUTObTbpXwkPifA/f3u1RcBOBzNlgfOjTwv7voXvEAdAk9S4N7uuhrLQCLJfp7TsJyscVPmNtkPS7Dnoe34MGKsuyBwAWQ+fgy9PHOj/uRFDS1bRwDhU=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0765.namprd21.prod.outlook.com (2603:10b6:300:76::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.15; Tue, 20 Apr
 2021 21:23:53 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f%5]) with mapi id 15.20.4087.015; Tue, 20 Apr 2021
 21:23:53 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: ** POTENTIAL FRAUD ALERT - RED HAT ** [PATCH v2 1/1] Drivers: hv:
 vmbus: Increase wait time for VMbus unload
Thread-Topic: ** POTENTIAL FRAUD ALERT - RED HAT ** [PATCH v2 1/1] Drivers:
 hv: vmbus: Increase wait time for VMbus unload
Thread-Index: AQHXNaBuLy1LL9sLv0KzHhyYBrtnaaq9JL8AgADDvaA=
Date:   Tue, 20 Apr 2021 21:23:53 +0000
Message-ID: <MWHPR21MB15937990D10174A63E65F579D7489@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1618894089-126662-1-git-send-email-mikelley@microsoft.com>
 <87tuo1i9o5.fsf@vitty.brq.redhat.com>
In-Reply-To: <87tuo1i9o5.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b6cef386-6085-4b51-863b-964f0422d527;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-20T21:12:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd083d24-5066-433e-8dfe-08d904429962
x-ms-traffictypediagnostic: MWHPR21MB0765:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB0765393E50D014187AA6179FD7489@MWHPR21MB0765.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KI5oOp9Y9aZOIOc7lb4u8Dygnvlnp89oXxy4fu+dGUCS0ZC3/TIWhI/2/A1u2xIAI3pjkOwnlMM5v6YJE7KWKu2VijrNVDOvsMtDCZt34d7hmmhCqfNRjQoXhcIefcp/dAq1l2cYNHVPAeIoesp2cAGfmaiR00diFIB0eol2E/WtdhSJUhUyb35BSbZNKcpIJhsZUS0edUWy+BVniC2VNLxQCwxcVvCxobhYXMSJWxnGDJCElLLJLWsMkNkRKKSYIZEJaOIaMMHkzeN/SeGrXgljj5PQnwH83zh7i3OLzcy8GRAXDvNwiQWtyqZ/E1Tbpq5ARqEn0QDBldHA9eSn7/SawhvAgcblzs/nz/7DarR7rYSVVTeTzMC5Lk/eSh97MXfBn2digmR+QjhEmpuHE9H4qUNv2TU3S4By/PZOxcawZkZDGRWBCoUfvA+wzYGL0UlQCtrvFolYtzSt1CQal4+HYUdC86nJdu+9cSHboaXxxfs2cER9j56zrzyJ4WnilnLGGdBXQnNcMVfZh26R8bE9SzuhzUEfe4fMAv9LlNdoILuQtLYdJcO8i5cVToVZWfOar68QOUMNr065+0ibsmFUk3M/C5EM1hh5TYllJXvFiMcVAI64Q2W2rqgkTqElgvl0rgBgOCl/wIVmKvqo0Vq1afGzuK8W9ylAOf6z6WY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(66946007)(66476007)(66446008)(76116006)(54906003)(66556008)(10290500003)(82960400001)(7696005)(6506007)(64756008)(33656002)(316002)(52536014)(186003)(8936002)(26005)(8676002)(71200400001)(2906002)(86362001)(122000001)(15650500001)(38100700002)(6916009)(9686003)(55016002)(83380400001)(107886003)(478600001)(8990500004)(82950400001)(4326008)(184083001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1HJTgLARKzjJ1GIENetd8QwkRY13xL/UZYrbf4RnGOhYNDYCIeY+sTKzjgTx?=
 =?us-ascii?Q?mdLPhalGhOdGfdjRXxRuUMCv245uohO+KKA5qQw9fO4093pjPuhQ601boR0A?=
 =?us-ascii?Q?OI2Ped+ItAskC6BrTsYth0VgJr3yS7Y0mhoS3hGsrgjbO22D7vXW0+nOClR0?=
 =?us-ascii?Q?e1PUH1QMUuixzjrfnay+IbfLe/rKwelnkQ5xxMhwdnOOsDJ6/Frse4xABlUe?=
 =?us-ascii?Q?JxAmj6zGmBbkIirIWZ48uwzkXCjIaBL/FEAukcBQmRvPi2mFg4JGh9tek3Sg?=
 =?us-ascii?Q?vwBIU3p3KnJwQmPm1nAt9Pe0rdhG5aWpTSh/aIkkUIAGc9L21bCbaLGbxOsZ?=
 =?us-ascii?Q?FCUqVAQNJj13WNsHGkVDE+F6iC4haNsuvtEet7MDDSnVyGWQaWdjg/xVirOp?=
 =?us-ascii?Q?1BYELsd5fs4gF5x9MyDzWn41NjYCr8z3TNOW64lVcyE7R0Di/y6DO39rwmWW?=
 =?us-ascii?Q?XQpMTqG4xV+Joe/41RMi+ioyxuTPa5Tfa0152Jv48tnJEQbe3T5rr4VJ44AM?=
 =?us-ascii?Q?Me37P6UgLf8q7ABLYkyYPnlE9hSlZK1xwOtaSbsb4C9ulZ2mY+fhWxro0DcW?=
 =?us-ascii?Q?m+DRaJqnMrD6rK+ppUwO6Yi2Y95vOVIaaxaxWfvS/2iCBfo3tUqJVEl56IIe?=
 =?us-ascii?Q?pe97XsKxF5z5GebMjaM+NrNLKgckJdd0pK1MgO0W09LphVC6ExPmCBoMI/v2?=
 =?us-ascii?Q?yv0WOQlX/TvgGCu/DA5VlEgY4SjZtr8emlkALQ6iN3JMs6O1UMAh77yVsT5p?=
 =?us-ascii?Q?IPn/eeZue8A8h2PngGFmlfqNWGDM+IphBseURQRz9srFGInb63X9uqfMAGjl?=
 =?us-ascii?Q?5TVAMd4Aj/0v4EQqEGlELleAfb04ICcNcRVNjCWwvuxrrXQTIEP7SojUCxJv?=
 =?us-ascii?Q?/Q9jWz/JXbwQ6apqKS55Ino/7zvgixsFwq+aA0H9CmXjrsVfue40+sci3bIo?=
 =?us-ascii?Q?K6OtOVnM+BkREmUrGvGB1WhOLjAmjIB1lyHH/FRN3TMj0d5jgkQBy9KdLW07?=
 =?us-ascii?Q?xVV/Kvi0VtYouq0DckkFJf3h36oC9DycpKR+E10q79jmbQdcehRQoKDImkPQ?=
 =?us-ascii?Q?j5fDKSIQRhMqyC44Ah+FINZb7nipyDysvbJCO1uvvcIryjgpbExya80iN2ZH?=
 =?us-ascii?Q?BNAPSXSZBJIcg0bCPpVFpskgDy8cFGgXGj90rIcDoGAEA/K3iTMd9KlmPWe4?=
 =?us-ascii?Q?Ld2B0X4WKNluqXOvMidIkNJxwfrtaSarqGG2yq/sQaTc4NG8tIILTir5HSfE?=
 =?us-ascii?Q?agl+MoZ+EalJFlf2IEZY+O98DP/JqYPD+w5RfW06k94ZVn2Pc5Q8r5SkGGCx?=
 =?us-ascii?Q?HEqSg7/+aJuaxoUdBZnOqSSe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd083d24-5066-433e-8dfe-08d904429962
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 21:23:53.6112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nzJeL82LoQ+C8TRFuea9SamU3cQY9lC55IgrpntIJ+D3FyPW5lxOdK40E4sUy9dqepfIsdK16QNo4Zm6cLx2L89rBuh5siukcj2C2p7POhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0765
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Tuesday, April 20, 2021 =
2:32 AM
>=20
> Michael Kelley <mikelley@microsoft.com> writes:
>=20
> > When running in Azure, disks may be connected to a Linux VM with
> > read/write caching enabled. If a VM panics and issues a VMbus
> > UNLOAD request to Hyper-V, the response is delayed until all dirty
> > data in the disk cache is flushed.  In extreme cases, this flushing
> > can take 10's of seconds, depending on the disk speed and the amount
> > of dirty data. If kdump is configured for the VM, the current 10 second
> > timeout in vmbus_wait_for_unload() may be exceeded, and the UNLOAD
> > complete message may arrive well after the kdump kernel is already
> > running, causing problems.  Note that no problem occurs if kdump is
> > not enabled because Hyper-V waits for the cache flush before doing
> > a reboot through the BIOS/UEFI code.
> >
> > Fix this problem by increasing the timeout in vmbus_wait_for_unload()
> > to 100 seconds. Also output periodic messages so that if anyone is
> > watching the serial console, they won't think the VM is completely
> > hung.
> >
> > Fixes: 911e1987efc8 ("Drivers: hv: vmbus: Add timeout to vmbus_wait_for=
_unload")
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> >
> > Changed in v2: Fixed silly error in the argument to mdelay()
> >
> > ---
> >  drivers/hv/channel_mgmt.c | 30 +++++++++++++++++++++++++-----
> >  1 file changed, 25 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> > index f3cf4af..ef4685c 100644
> > --- a/drivers/hv/channel_mgmt.c
> > +++ b/drivers/hv/channel_mgmt.c
> > @@ -755,6 +755,12 @@ static void init_vp_index(struct vmbus_channel *ch=
annel)
> >  	free_cpumask_var(available_mask);
> >  }
> >
> > +#define UNLOAD_DELAY_UNIT_MS	10		/* 10 milliseconds */
> > +#define UNLOAD_WAIT_MS		(100*1000)	/* 100 seconds */
> > +#define UNLOAD_WAIT_LOOPS	(UNLOAD_WAIT_MS/UNLOAD_DELAY_UNIT_MS)
> > +#define UNLOAD_MSG_MS		(5*1000)	/* Every 5 seconds */
> > +#define UNLOAD_MSG_LOOPS	(UNLOAD_MSG_MS/UNLOAD_DELAY_UNIT_MS)
> > +
> >  static void vmbus_wait_for_unload(void)
> >  {
> >  	int cpu;
> > @@ -772,12 +778,17 @@ static void vmbus_wait_for_unload(void)
> >  	 * vmbus_connection.unload_event. If not, the last thing we can do is
> >  	 * read message pages for all CPUs directly.
> >  	 *
> > -	 * Wait no more than 10 seconds so that the panic path can't get
> > -	 * hung forever in case the response message isn't seen.
> > +	 * Wait up to 100 seconds since an Azure host must writeback any dirt=
y
> > +	 * data in its disk cache before the VMbus UNLOAD request will
> > +	 * complete. This flushing has been empirically observed to take up
> > +	 * to 50 seconds in cases with a lot of dirty data, so allow addition=
al
> > +	 * leeway and for inaccuracies in mdelay(). But eventually time out s=
o
> > +	 * that the panic path can't get hung forever in case the response
> > +	 * message isn't seen.
>=20
> I vaguely remember debugging cases when CHANNELMSG_UNLOAD_RESPONSE never
> arrives, it was kind of pointless to proceed to kexec as attempts to
> reconnect Vmbus devices were failing (no devices were offered after
> CHANNELMSG_REQUESTOFFERS AFAIR). Would it maybe make sense to just do
> emergency reboot instead of proceeding to kexec when this happens? Just
> wondering.
>=20

Yes, I think there have been (and maybe still are) situations where we don'=
t
ever get the UNLOAD response.  But there have been bugs fixed in Hyper-V
that I think make that less likely.  There's also an unfixed (and maybe not=
 fixable)
problem when not operating in STIMER Direct Mode, where an old-style
timer message can block the UNLOAD response message.  But as the world
moves forward to later kernel versions that use STIMER Direct Mode, that
also becomes less likely.   So my inclination is to let execution continue =
on
the normal execution path, even if the UNLOAD response message isn't
received.  Maybe we just didn't wait quite long enough (even at 100 seconds=
).
It's a judgment call, and it's not clear to me that doing an emergency rebo=
ot
is really any better.

As background work for this patch, we also discovered another bug in Hyper-=
V.
If the kdump kernel runs and does a VMbus INITIATE_CONTACT while the
UNLOAD is still in progress, the Hyper-V code is supposed to wait for the U=
NLOAD
to complete, and then commence the VMbus version negotiation.  But it
doesn't do that -- it finally sends the UNLOAD response, but never does the
version negotiation, so the kdump kernel hangs forever.  The Hyper-V team
plans to fix this, and hopefully we'll get a patch deployed in Azure, which
will eliminate one more scenario where the kdump kernel doesn't succeed.

Michael

> >  	 */
> > -	for (i =3D 0; i < 1000; i++) {
> > +	for (i =3D 1; i <=3D UNLOAD_WAIT_LOOPS; i++) {
> >  		if (completion_done(&vmbus_connection.unload_event))
> > -			break;
> > +			goto completed;
> >
> >  		for_each_online_cpu(cpu) {
> >  			struct hv_per_cpu_context *hv_cpu
> > @@ -800,9 +811,18 @@ static void vmbus_wait_for_unload(void)
> >  			vmbus_signal_eom(msg, message_type);
> >  		}
> >
> > -		mdelay(10);
> > +		/*
> > +		 * Give a notice periodically so someone watching the
> > +		 * serial output won't think it is completely hung.
> > +		 */
> > +		if (!(i % UNLOAD_MSG_LOOPS))
> > +			pr_notice("Waiting for VMBus UNLOAD to complete\n");
> > +
> > +		mdelay(UNLOAD_DELAY_UNIT_MS);
> >  	}
> > +	pr_err("Continuing even though VMBus UNLOAD did not complete\n");
> >
> > +completed:
> >  	/*
> >  	 * We're crashing and already got the UNLOAD_RESPONSE, cleanup all
> >  	 * maybe-pending messages on all CPUs to be able to receive new
>=20
> This is definitely an improvement,
>=20
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>=20
> --
> Vitaly

