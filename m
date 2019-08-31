Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81F2EA41D1
	for <lists+linux-hyperv@lfdr.de>; Sat, 31 Aug 2019 04:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfHaCy7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 30 Aug 2019 22:54:59 -0400
Received: from mail-eopbgr1300115.outbound.protection.outlook.com ([40.107.130.115]:56032
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726649AbfHaCy7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 30 Aug 2019 22:54:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRkLZp5qjasTbQ5LGwM4ByXNKTyiaAEP1iRFDwvDTHzN/s6l/AMMCZSD/qBonnuMXEeBaLlp8/5Y4DMXXiy+gfLriXoAfDPVQ4vmxRbwuDkI5sY8uQVKtnPjE5UxfeWEsZOCACesLvdW8L6wH0d+euxUB3WynkU4kGP7y9EDyiJkZtQG/hluWv7DRGe4+mNFv9NuZNL//MMOAp6oDWVRxVvd3NFxP3XRv8t6rsw5x9oWyqz6PpwISOXeXKl1hewOvHzr2kmOPIlo+f5TVJsMbJ7ycoNE9xhAiIMfmypTekXyLd5qpgwmP0gdQcumaDB1P3rK10dC5GCq0C5irVkGMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRO4yRQfhudgebWTdcWDAcqooKIky4d6jrKNW6cuNsE=;
 b=KiQbDSoABHAhSdrAOJTk5+Hy8DtxqvZBQviGFcq/dWpdPqxiEjFiLNWo5hBP38zdnpBa0myv1TBd2Vf6jaY7sie4bzTos3C/bZ0QQOBQZdiLn+FLDDM04Lr3EalpzVhmAtoOJR3vthu4F3wdsb51hoAUgYfH9qAOtDsUmeSv/CHaqLX6i79fh7huIMABJy+RRrvyqNMmLJSH13BSIodt5dbn6cms2LzgDHpKfOdIdIHcA3jXobLBjirYYGxXHGu5XAsqdFTAuEkTvkGp2FJbOKha+8vDo8f0aM9odAPNcwXnGwKjnIUdQQiuUAhsjmk00z1T2a3Uj1sARWutQcwxYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRO4yRQfhudgebWTdcWDAcqooKIky4d6jrKNW6cuNsE=;
 b=WoZYA+ovHtcqf1mlWRbuQR1freJfh5LqnTLflpoe38xGBWDnhNdPFSvfZl5IZiJyomQy1gOMslx2Dl5NVpacVQGKXF4rnOglV1zpzQanODv2FKtoPSDSAb7dL17Cb0KnxZu/y58gmKQrOgfJ8UDbC8nLsPB342Jgfl2fncJLgfA=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0172.APCP153.PROD.OUTLOOK.COM (10.170.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.3; Sat, 31 Aug 2019 02:54:52 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3%4]) with mapi id 15.20.2241.006; Sat, 31 Aug 2019
 02:54:52 +0000
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
Subject: RE: [PATCH v3 11/12] Drivers: hv: vmbus: Suspend after cleaning up
 hv_sock and sub channels
Thread-Topic: [PATCH v3 11/12] Drivers: hv: vmbus: Suspend after cleaning up
 hv_sock and sub channels
Thread-Index: AQHVVvng6z85mw3tx0a0PJJjmBG2NqcJLWIggAtrjAA=
Date:   Sat, 31 Aug 2019 02:54:51 +0000
Message-ID: <PU1P153MB0169FE9BF7EC648490AB19F6BFBC0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1566265863-21252-1-git-send-email-decui@microsoft.com>
 <1566265863-21252-12-git-send-email-decui@microsoft.com>
 <DM5PR21MB01379C31FC628F4666413804D7A40@DM5PR21MB0137.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR21MB01379C31FC628F4666413804D7A40@DM5PR21MB0137.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-23T20:16:43.0778197Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=338b832f-f4fa-45d4-b0dc-f0e1b91ce4cc;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:5cbd:8ecd:62e5:20b7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b6c7855-ba94-4f4f-0562-08d72dbe9868
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0172;
x-ms-traffictypediagnostic: PU1P153MB0172:|PU1P153MB0172:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB0172CCA20A760FF3F45FC075BFBC0@PU1P153MB0172.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 014617085B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(199004)(189003)(71200400001)(446003)(11346002)(52536014)(6246003)(305945005)(2201001)(74316002)(14454004)(476003)(33656002)(486006)(5660300002)(4326008)(6116002)(76176011)(55016002)(64756008)(9686003)(53936002)(66946007)(7696005)(66556008)(99286004)(66446008)(8990500004)(46003)(6506007)(10090500001)(76116006)(71190400001)(86362001)(15650500001)(186003)(8676002)(81156014)(81166006)(256004)(14444005)(229853002)(2906002)(316002)(22452003)(66476007)(25786009)(2501003)(10290500003)(6436002)(8936002)(110136005)(1511001)(478600001)(102836004)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0172;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Wl4B56mp7+ALB5J8CJbKURQonUbTx1xMg7Q3JO0BFwct9MRJhwT/bpWdOtmPOO+fxG2CuJF6R52hj3N7CMcsaedIeH9IJkxIV6dLL9YyeF0KMqmsKjKNj5OplnvHeO3D+yNlGxuc7ihw7PCUX1htuDUXSvGu+e3nf/qPrazNsif//rYn5ClyOhJnxwocLL5PbG5rKZEpwYNCH14qn8vp+N/HEE3qWP0b3LTUgROOJgftvIOHRLBMaysIKYkc7BDNyrbC3klTrHlRhNA2q/WCDSVSWgeFAqoIvlzsTzLBf+dkgaXkzGgh0lxgEkpBNiVa4PN0VfV9lytvWmmGcWnAaLWnWc5LNbIAA2dG0tLDXesFrcEMYc29RkKRre67e7OUVXM8cW0XBWeTwmjObJaV7nWuinQhfyZLWv3+L6kv8XY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6c7855-ba94-4f4f-0562-08d72dbe9868
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2019 02:54:51.6017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aN7SxyyQmVBxZQ02h5n4kGfZDvVzP+hiuZ33LcIIvxesd4T3vFdsRZDqhKXO1OZlF6JzBYMI3/fkFoBZ2ptSHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0172
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Friday, August 23, 2019 1:17 PM
>=20
> From: Dexuan Cui Sent: Monday, August 19, 2019 6:52 PM
> >
> > diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> > @@ -499,6 +499,8 @@ static void vmbus_add_channel_work(struct
> work_struct *work)
> >  	return;
> >
> >  err_deq_chan:
> > +	WARN_ON_ONCE(1);
> > +
>=20
> Why this change?  I was thinking maybe it's a debug statement that got
> left in.

This is indeed a debug statement. :-)=20
I was not so sure if the error handling is absolutely correct there.
I think I can remove this WARN_ON_ONCE() since almost all of the possible
error paths have a pr_err(). We can make an extra patch to fix any bug in
the existing error handling code. BTW, it should be pretty unlikely to reac=
h
the "err_deq_chan label" in practice.

> > @@ -1021,6 +1044,11 @@ static void vmbus_onoffer_rescind(struct
> > vmbus_channel_message_header *hdr)
> >  		}
> >  		mutex_unlock(&vmbus_connection.channel_mutex);
> >  	}
> > +
> > +	/* The "channel" may have been freed. Do not access it any longer. */
> > +
> > +	if (clean_up_chan_for_suspend)
> > +		check_ready_for_suspend_event();
> >  }
>=20
> Having to add the above lines twice is a bit clumsy, but the problem is
> the overall structure of the vmbus_onoffer_rescind.  The early return in
> the case of a rescind_callback function is a bit weird, but I guess it ma=
kes
> sense since from what I can tell, only uio and hv_sock have rescind callb=
ack
> functions. Some minor restructuring might be warranted, but I don't feel
> strongly about it.

I agree. We should restructure vmbus_onoffer_rescind(), but I think we can
do it in a separate patch. Here in this patch I'm focused on the minimal
required change for hibernation.

> > +	/*
> > +	 * Wait until all the sub-channels and hv_sock channels have been
> > +	 * cleaned up. Sub-channels should be destroyed upon suspend,
> otherwise
> > +	 * they would conflict with the new sub-channels that will be created
> > +	 * in the resume path. hv_sock channels should also be destroyed, but
> > +	 * a hv_sock channel of an established hv_sock connection can not be
> > +	 * really destroyed since it may still be referenced by the userspace
> > +	 * application, so we just force the hv_sock channel to be rescinded
> > +	 * by vmbus_force_channel_rescinded(), and the userspace application
> > +	 * will thoroughly destroy the channel after hibernation.
> > +	 */
> > +	if (atomic_read(&vmbus_connection.nr_chan_close_on_suspend) > 0)
>=20
> At first glance, the above line seemed useless to me.  You could just do =
the
> wait_for_completion() unconditionally.  But is the intent to handle the c=
ase
> where the VM never had any sub-channels or hv_sock channels, and so
> nr_chan_close_on_suspend never went above 0? =20

Yes.

> If so, a comment might be helpful.
> > +wait_for_completion(&vmbus_connection.ready_for_suspend_event);

Ok. I'll add a commnt for this in v4.

Thanks,
-- Dexuan
