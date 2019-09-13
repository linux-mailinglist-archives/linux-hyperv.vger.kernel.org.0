Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79B8AB2448
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Sep 2019 18:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfIMQnc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 13 Sep 2019 12:43:32 -0400
Received: from mail-eopbgr1320101.outbound.protection.outlook.com ([40.107.132.101]:42080
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387977AbfIMQnc (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 13 Sep 2019 12:43:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dt0FmWFRCjGhwQq2VZ61uDgSfL3U4ZzUXtOlTnKWwjQXt9FaJnRC1n6B5htshxDBCTWTT3X3kOagIVooLKhI/EQgy6aUYXyDOhWqantmrbKzTj0pSC2EyBuiUqtfcneW0kr5k6xm3zvgLJGdZqDdL79GEF6SfXRCD1EDm9pEm+PQalMc5V3dJ4gDYPdJjUQTN5VMUmw4Sn0HavYnzb+6Axlhl+o66ydrPu4qtOSG04slSnAAVJo5JQi+sux+lx20ueR2nTQHq3HJ0kzoGhuj1zRORXMq0+RLAssBba95rmGpuES+9L7tSOW508ubUg8IlDzOvqUvfSHtJEa9evNRvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyUD1V+n46Hs6GZ706iemZ0kGlO64KOOEBfgJi8T95o=;
 b=cMEfChDGX4rYyVFY6pGJQkOTh2wOyofcVSUIIsmhNPN+Nw67jbV0DqQt/VBglFEpRJpfr6W9duoEhhoWaqUxbUz4QTPJgirG3DqCh4ChMLC/L7Fk8hsEW3DlrAQM1cuDwhz7ttGFXOzLlMRpYHPNTeAAP2DLpsHZKdpQRKDpNZUeJrtO88Bx+uTr/c1/WgbN8g8pupG62ho0jI+JEDc4jwjp8tg7rP0zhuw+ulWiT9vNcfbL7Bni8MuXS34o/CeDTT2oGIyCSEE41nh7iYnVkqj8PveoN4aKaIVpLMgMX8NcC9kkfRzB589NjvrDL2tjq0zBkhoaTvM87dGQUJ/73Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyUD1V+n46Hs6GZ706iemZ0kGlO64KOOEBfgJi8T95o=;
 b=BjqSkyZPdHc1ULjvEy/upURG2gqRh9PM5fOJxUEkjp59UNVHf/5/WjU27V/7vYW3q60+iY9qCoOkbR4B9V04UC5t7Z6jPmBiKW2DYHakEuEeQVIHAEtYjhZWrdKVwCQRd4I3lr9q0pm9Opw6MnaGVrD2OKasCKSMDlJ2RfMsb/8=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0122.APCP153.PROD.OUTLOOK.COM (10.170.188.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.12; Fri, 13 Sep 2019 16:42:46 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3%4]) with mapi id 15.20.2284.009; Fri, 13 Sep 2019
 16:42:46 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH 2/3] hv_utils: Support host-initiated hibernation request
Thread-Topic: [PATCH 2/3] hv_utils: Support host-initiated hibernation request
Thread-Index: AQHVaYbpS3JYwkEU8UOlr6/1A/pZaqcpNTMA
Date:   Fri, 13 Sep 2019 16:42:45 +0000
Message-ID: <PU1P153MB01695D3A23744080FF1EE437BFB30@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568245130-70712-1-git-send-email-decui@microsoft.com>
 <1568245130-70712-3-git-send-email-decui@microsoft.com>
 <87a7b9cwfj.fsf@vitty.brq.redhat.com>
In-Reply-To: <87a7b9cwfj.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-13T16:42:42.9538298Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=81e69111-edc8-459e-ae89-e1f800fe1af4;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [73.140.237.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b7e9140-66e9-40b2-d6ce-08d738696802
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0122;
x-ms-traffictypediagnostic: PU1P153MB0122:|PU1P153MB0122:|PU1P153MB0122:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 1
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB01225C68C5FBE91EDBA7972BBFB30@PU1P153MB0122.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(51914003)(199004)(189003)(186003)(446003)(25786009)(6506007)(86362001)(11346002)(66066001)(8990500004)(305945005)(10090500001)(7736002)(54906003)(22452003)(478600001)(52536014)(6916009)(33656002)(966005)(316002)(256004)(74316002)(14454004)(14444005)(10290500003)(4326008)(8936002)(71190400001)(71200400001)(76176011)(66446008)(99286004)(64756008)(76116006)(66556008)(66946007)(66476007)(7696005)(81166006)(102836004)(26005)(8676002)(6306002)(6436002)(55016002)(6246003)(9686003)(81156014)(486006)(5660300002)(2906002)(6116002)(3846002)(229853002)(476003)(107886003)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0122;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yKygbCfaKpDo3bv1pqZqr0x/9pusMAxC9tWHqVL5anCgxnFvowdaBAc6emoP2Kwq4JP2FR1llAb1evxHM6aAYc8ebYq+9H7p9SzKNDXI4rjIXRADSmVRkPm9U3WHAnK3FRFwYHBy+T9DtA/seT2Yo9rVmiTsB/qXYUi/GOY8ZCfxOSdK/nF+yIY6G703WyizCQTJ3S+k82T/lPFeqJqM5FyUIJqdkGh+bC6v1mESpR7P4hf9J70gc4ZhSvtaN1ljYFGuubg9u+0eSA/u1bqElmrZEiTsUDMmi3pM0W7UYJMDqLsdKYQDOFTt6A13ldgstCl3lM3Y2w9uuV+vBuzTNIHI2e1e6I4Lf6867WLVJkMRGLRDmlbcbRWejtEMJHgwcU5GpwXFMpPO8JzfGbRLrKocb291Xp/M7fIHAGnaYEI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7e9140-66e9-40b2-d6ce-08d738696802
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 16:42:45.9495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yCDQhfCtt4UpZTB4wi6uLD7PG+Pj6vK1SEI24uGmYS6ZSKcjoJrLTlW8oq53Oe1Mvfmqe7GCY6PzvS6nqL/nQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0122
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> Sent: Thursday, September 12, 2019 9:27 AM
>=20
> Dexuan Cui <decui@microsoft.com> writes:
>=20
> > +static void perform_hibernation(struct work_struct *dummy)
> > +{
> > +	/*
> > +	 * The user is expected to create the program, which can be a simple
> > +	 * script containing two lines:
> > +	 * #!/bin/bash
> > +	 * echo disk > /sys/power/state
>=20
> 'systemctl hibernate' is what people do nowadays :-)

Thanks for sharing this command!=20
=20
> > +	 */
> > +	static char hibernate_cmd[PATH_MAX] =3D "/sbin/hyperv-hibernate";
> > +
>=20
> Let's not do that (I remember when we were triggering network restart
> from netvsc and it was a lot of pain).
>=20
> Receiving hybernation request from the host is similar to pushing power
> button on your desktop: an ACPI event is going to be generated and your
> userspace will somehow react to it. I see two options:
> 1) We try to hook up some existing userspace (udev?)
> 2) We write a new hyperv-daemon handling the request (with a config file
> instead of hardcoding please).
>=20
> Vitaly

Thanks for the suggestions!=20
I prefer the udev method, e.g. something like this:

	char *uevent_env[2] =3D { "EVENT=3Dhibernate", NULL };
	kobject_uevent_env(&ctx->dev->device.kobj, KOBJ_CHANGE, uevent_env);

Then the user is expected to create the below udev rule file, which is appl=
ied
upon the host-initiated hibernation request:

root@localhost:~# cat /usr/lib/udev/rules.d/40-vm-hibernation.rules
SUBSYSTEM=3D=3D"vmbus", ACTION=3D=3D"change", DRIVER=3D=3D"hv_utils", ENV{E=
VENT}=3D=3D"hibernate", RUN+=3D"/usr/bin/systemctl hibernate"

The full patch is here:
https://github.com/dcui/linux/commit/0d92b53f48a8dca92bbd3493ea9c5bd098c996=
23

I'll post it as v2.

Thanks,
-- Dexuan
