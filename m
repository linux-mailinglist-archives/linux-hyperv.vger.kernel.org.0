Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000CD1B36A6
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2020 06:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgDVE61 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Apr 2020 00:58:27 -0400
Received: from mail-eopbgr1320139.outbound.protection.outlook.com ([40.107.132.139]:27011
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725808AbgDVE60 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Apr 2020 00:58:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTeA/5uc3yBZ7JGI3nXth63ePDNDXKsGq1fz6qUfv1VmLlYRO2WfvYdeBpehrdTkEvCVtmeSSPw0lpiEZuGx7gnOzU2+8n4XZnwVBP1ICssrDjASLMdQMoXM3g8gA8cunZaEkSqoapQ/0ieko5/yEvbNGGaePiltjQnEhnh+HP3bv3K4eqd3AEcLD++/fQz5tPoEthzjJIjsBHlP9r+akX7CPSb2AkvWq6opHzaJ1skjEixel1Z8GXfx+YR+BuJr1Z/1vr/sBkNZtXkBvvxoWJS+35V/GqkbkqnbURGMGV0qezkNlQOHKXBTN5h6C9m+MLtxzibaFR+8Qjt9vrsRwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLJQ03erXgoO2KA5AWJFLMKgNW+cTDJj7f03tFkedRg=;
 b=Ncz1uyNWnoRaRDWnmU9kQ933+qH20IS4g3x9DkZyWv3/tOq2D2kQhuxvbPBy8i1emmF7lbvE0u+9mlEx+CG70fHq52I04HBbv4Dg7cMKgdHlA+T0YV1KmydR0422io6PnpzvR9agEfp0+REzXwcV6NqA4gWmkf67ZEgzD3DXtpzVWDOcIx3oExaVAUVOSD9opDcvw8YzuD2wN0PF3BNAaecLBsIGIUng9Aqx5t330qDwnFpdhjv9Wqs2b2wD1fWlypzcKUCXtAWXmT4qCEd8pwrgXq+RkhY5EUS8dpjAyI1fb6kfyx3axsFe5oZFusr7A2IEx1gp7/XTze1dGk4wjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLJQ03erXgoO2KA5AWJFLMKgNW+cTDJj7f03tFkedRg=;
 b=grN/5bJ2u0MeBewFt0t+WAc7eRvTsAS2ZlAYjP+KPzJGtdmqPo4gDIz6yxKGT1LOZuEQZL/3drdZieKMpfEUyiNCZ8jbcW0mcNSJjcuApUdFjUnUB+OaatFQjjcmtZHdNRrRNPF4T45QalZoJeh9ukrYxXCXU/TnNaBfUkRs51E=
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM (2603:1096:203:b2::12)
 by HK0P153MB0243.APCP153.PROD.OUTLOOK.COM (2603:1096:203:ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.2; Wed, 22 Apr
 2020 04:58:14 +0000
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a]) by HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a%2]) with mapi id 15.20.2958.006; Wed, 22 Apr 2020
 04:58:14 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Ming Lei <ming.lei@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
CC:     Josh Triplett <josh@joshtriplett.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "hare@suse.de" <hare@suse.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] scsi: storvsc: Fix a panic in the hibernation procedure
Thread-Topic: [PATCH] scsi: storvsc: Fix a panic in the hibernation procedure
Thread-Index: AQHWGEVb6DFeJK2tFE2eFTHRpRyDH6iEXZcAgAArmvCAAAOn4A==
Date:   Wed, 22 Apr 2020 04:58:14 +0000
Message-ID: <HK0P153MB0273CF2901E193C03C934A47BFD20@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
References: <1587514644-47058-1-git-send-email-decui@microsoft.com>
 <20200422012814.GB299948@T590>
 <HK0P153MB0273B954294B331E20AACB41BFD20@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
 <20200422020134.GC299948@T590> <20200422030807.GK17661@paulmck-ThinkPad-P72>
 <20200422041629.GE299948@T590>
In-Reply-To: <20200422041629.GE299948@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-22T04:58:11.8946466Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=098aa2b8-85b6-4099-aff3-dc939071f319;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:a0d3:b235:bb01:7ca2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 20bcb216-a7f1-4a5d-219e-08d7e679c3b6
x-ms-traffictypediagnostic: HK0P153MB0243:|HK0P153MB0243:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0P153MB0243F3F046F302C65DF65CCBBFD20@HK0P153MB0243.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03818C953D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0P153MB0273.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(10290500003)(186003)(6506007)(110136005)(76116006)(8676002)(478600001)(66946007)(71200400001)(5660300002)(66476007)(66556008)(64756008)(66446008)(8936002)(7696005)(52536014)(81156014)(4326008)(86362001)(316002)(8990500004)(7416002)(33656002)(82960400001)(82950400001)(2906002)(54906003)(9686003)(55016002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /pCbL2m8y8tM3z1UEXlzzwYR5FtJiUu+YhETQBLxHeCuzGIicvlu2oD+vdbPoej0ayfX7EQuBiiEO/qlkQOgjLkDfrNgL6xkUQrtgjG1qFkXj9YNT1+oVIsdTI2RRKJ+Lhh9bSckFX6ipE6JyP8ne691gftvv0nmCwRsYq0Ki3DLHuNZo6uZT4idiBsx1hkD0Zy6Nk4WfDWrGFvQcnluw3mJz/74GXdQPH1Ax5J2FBVjXALzMu8BKZQkIc7RUvvlXdy2m8kXXGQlFcEcJ5fSLWePW0hx93gC19nrhogfzskD2v8EsnHYFPdhjKhc3SWCrM1x7sT4Uz+xIWFDWUIupSWOJoKNpzE1yrQuBlIJGVDTTjCDDtO9OxqLp4wa2Kx+OEn1PNa0KsZY9hvKPt/jLN/IWxxNSX+qi+XZJvuqs0Inj4s3hmPqo3O5FSu0R41k
x-ms-exchange-antispam-messagedata: lMYkkahUE9yzJAR5OjObNBWjuf/hXzP0IBZnlMP3dnEwypgO6rk/Fi9u4YC35BAIAmyJaZ8hGeh15A7p5totf4C+x6h0RGPDbY+Z9duSPlR+HDm2WxDahtCcO/SXqCukihT+wuYPweYp0a1fTKH453xxDGpGqkSrM3HSBAWuyLHTk8muGKGTbRa5V12UpHsVV4KJh6WSXnqbDAqeyK/enb2q4pLjQkPctgXZr5X6fnbBVfPBfBouG4Wm6FqmQnJ5UcjI2kRoxJ1V70a63VXV0Z4Q/RJa4ChEzubHpyJENMpT1FL7mcxa/QcXkY0hBX6y+cyWK3uWD1vrVMWC2T3obH3e+n2LixitQKOMCOlVmIuko4Mjsd9V5FWR599ycwRyZ+W2hnBetZ8Ak6hhSRa1zM1yMzwGUHX0toOe4cxKoNRTPQRGR7qGDTtxztJiUwIDYEOCASWVjHGUkhTZODFqWLr/YOC1hdbI0k6ZkppiNyjkDtTX0RBtkBwribYa9Hb1nmQa7iqTYK5uU/vvTAfY1qgh/iDH1h80yv1iU2F+A3ZkbmEywQtHAenFY8gcCIZUrfCVx1xp1RMi0fbX3C9YuvUuETSEZceoHZFTR0H6KJEx8lG+ryDIJqMajtxUhC2pIiaE/vpamFKWsM+w4mIfVWsKqmLX51rpVgM+z7sYDB7IlM/utdJRNJZ85Wx8MFtwcuJcYgbCWTdNF5xu8UbnnR0bLYeXhz0bklZsp2243eUAQ2CfHoQ1B1RXxZhHd9YFWmsVXkHs8rY1kDWNUjrT+TRJbaTijiJ5TUf4mogZiggdPtj9MrKlGItPfQoJRwXKzzP5DPu3bUBkLbx3urUY172ebZFC0i+wS3OTJnXNZXc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20bcb216-a7f1-4a5d-219e-08d7e679c3b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2020 04:58:14.0861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ub6P7rs4CXkultXMGS+E5q46F02wtd8+h62s+7EWQK01kJ1z1cIodUL71PCjDKK/BvS4+VrDbQSxikXY/KHlDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0243
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Ming Lei <ming.lei@redhat.com>
> Sent: Tuesday, April 21, 2020 9:16 PM
> ...
> > > > When we're in storvsc_suspend(), all the userspace processes have b=
een
> > > > frozen and all the file systems have been flushed, and there should=
 not
> > > > be too much I/O from the kernel space, so IMO scsi_host_block() sho=
uld
> be
> > > > pretty fast here.
> > >
> > > I guess it depends on RCU's implementation, so CC RCU guys.
> > >
> > > Hello Paul & Josh,
> > >
> > > Could you clarify that if sysnchronize_rcu becomes quickly during
> > > system suspend?
> >
> > Once you have all but one CPU offlined, it becomes extremely fast, as
> > in roughly a no-op (which is an idea of Josh's from back in the day).
> > But if there is more than one CPU online, then synchronize_rcu() still
> > takes on the order of several to several tens of jiffies.
> >
> > So, yes, in some portions of system suspend, synchronize_rcu() becomes
> > very fast indeed.
>=20
> Hi Paul,
>=20
> Thanks for your clarification.
>=20
> In system suspend path, device is suspended before
> suspend_disable_secondary_cpus(),
> so I guess synchronize_rcu() is not quick enough even though user space
> processes and some kernel threads are frozen.
>=20
> Thanks,
> Ming

storvsc_suspend() -> scsi_host_block() is only called in the hibernation
path, which is not a hot path at all, so IMHO we don't really care if it
takes 10ms or 100ms or even 1s. :-)  BTW, in my test, typically the
scsi_host_block() here takes about 3ms in my 40-vCPU VM.

storvsc_suspend() is not called from the runtime PM path, because the
runtime_suspend/runtime_resume/runtime_idle ops are not defined=20
at all for the devices on the Hyper-V VMBus bus: these are pure=20
software-emulated devices, so runtime PM is unnecessary for them.

Thanks,
-- Dexuan
