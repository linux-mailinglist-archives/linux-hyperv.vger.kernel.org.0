Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EECB51A4A6A
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Apr 2020 21:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgDJT2q (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Apr 2020 15:28:46 -0400
Received: from mail-dm6nam11on2137.outbound.protection.outlook.com ([40.107.223.137]:52512
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726142AbgDJT2q (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Apr 2020 15:28:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHwjzSpa0BEKpSicECzvT3iYlQJ65Wu4M8mNHPRocPnIyFm5huLzbdLlNwnt0AiTH0J2DIkGmZ5LFE5ByB8uI13PoVqlvtihw1ZhfAdOtIPNhwvbW2W3LSAiMfUUNamG2ZaVOrgdetbigSJ0DUjhe2TXp1tk/kXG4sdGsnYomSCuntIBChUFz+v1VX80U7EYL+oiQxpkziBq2gPXU5nduTn5v4JC1P5qgQ6OvAnp4JhX1CVT0+ZHxyNg4NWilMb+uSZ54sGQfR6grv11UyDVRLuX3jRgnxdbzaYvg3i4iXFNeWZ1wcM0t3PgFQE3Kjtgix93UHkJr1y8Wm+dz2yv2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XDquZ7wZStcwkf7YgOaLLK6Jqi9VcJkdNIP+wauRDQ=;
 b=dHu/Dfa0aLHeAA4MKAPw91r8qekovwhz7Qodl+ftQkPg+2kYc47PYrPy3agUR1DUHLDiV/tRE2o+DiAWLXPkDkbPTNA0tylTaeeQNV4Afc9aENQm5hNyFX9GAcH0kzHX1JhqQgR4/hJwzbXnn0vIh4W/WvHBLG9uT+rIDtAHVTTVmpa109fI4uIILMxisU5hz2fV3eVomlG+kqL8hN0oCJb6cnFSZGFF8QKCPX/hIVlJtvxoiUPmqcfzlebqeGuz8L1GTepEsN55KuWcvubiak7pZYxs4U0TBdrrGx0m1tLaYjtZ+s3p43u8suaY1sPMo/dloLJvO92tz3LBbnynHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XDquZ7wZStcwkf7YgOaLLK6Jqi9VcJkdNIP+wauRDQ=;
 b=C8pTbB1/xs3d1IlQKGqUQHlh5USwefjRL5EDEWNh1u1moC29C2PoOx3M0TFq5p7GZCa8v4W8c644MzvTGixCKGTNNHTMQT8ylpPMeK837OZnBV1eKd55Ej5UAEg8NYKFNWr4YJm/fRdRbXgIUHzr7dNuc2tAz7Zcmrr5VaLSE94=
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com (2603:10b6:4:9e::16)
 by DM5PR2101MB0903.namprd21.prod.outlook.com (2603:10b6:4:a7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.19; Fri, 10 Apr
 2020 19:28:44 +0000
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::f54c:68f0:35cd:d3a2]) by DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::f54c:68f0:35cd:d3a2%9]) with mapi id 15.20.2921.009; Fri, 10 Apr 2020
 19:28:44 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH 06/11] Drivers: hv: vmbus: Use a spin lock for
 synchronizing channel scheduling vs. channel removal
Thread-Topic: [PATCH 06/11] Drivers: hv: vmbus: Use a spin lock for
 synchronizing channel scheduling vs. channel removal
Thread-Index: AQHWC6itsKaeBdvwWEmHT7pokTrAvKhyxLVQ
Date:   Fri, 10 Apr 2020 19:28:44 +0000
Message-ID: <DM5PR2101MB104791F7982BCD5FACD413EBD7DE0@DM5PR2101MB1047.namprd21.prod.outlook.com>
References: <20200406001514.19876-1-parri.andrea@gmail.com>
 <20200406001514.19876-7-parri.andrea@gmail.com>
In-Reply-To: <20200406001514.19876-7-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-10T19:28:41.9026771Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a0003f45-0a8d-419d-b192-ff821baa135a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5a87db32-537f-4940-a515-08d7dd856235
x-ms-traffictypediagnostic: DM5PR2101MB0903:|DM5PR2101MB0903:|DM5PR2101MB0903:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB090359444C3D5EDBCA66AE44D7DE0@DM5PR2101MB0903.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR2101MB1047.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(6506007)(7696005)(316002)(8990500004)(2906002)(54906003)(478600001)(86362001)(186003)(110136005)(10290500003)(66556008)(82950400001)(82960400001)(71200400001)(55016002)(66946007)(26005)(66446008)(76116006)(64756008)(66476007)(81156014)(8936002)(5660300002)(8676002)(52536014)(33656002)(9686003)(4326008);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AYSFOonZUcgDPVACCVsCZOOUCJ1aaIaJYtmbwwyC0f7C5CNphBend7x+qu0GeuPOugiCiLtuzE2V0lLQiO8ISPm7o1kSEc50SdqlULQ+T53j98F+jEZz0k2fq7B3WPQ8QLP1JPSlpn/jOFiyxqGYb2vnXVIR6PNGW40S9KWMvZh7V7puB/zOF6QFeWTJklexGJ5JMchfIZy5dcsyl40hIQHfh4v1sZJUdpEptdEyGHj29bfe2eSeiSxifATB59ePeipDr41n4nb7l3oaRbnxKUORiHgtGshHhig2pQuyDUW0y53teolIdtFKdefdfmQStLPVazp8gwehWRaqLvy1hI9CLj9pJuuAjHDVklWrKKZSPFMZ7d8Xqj8gx8gm+XvuhGIf0ahRiMMjVgsimKzUUSVz1fJBXWDlmkUg/EXeBF3+wiRBywLEPsbtzQnQbruG
x-ms-exchange-antispam-messagedata: 1AtFv0/amg4jUB4Ser9p5tPzd356yz/SlmT0C9+LHiujGVRnOYPhurin40W2Ni9vCJQe6rdb5exFXJIvFodC6atxpEyogPsarHJQiS1Xqmm3pKUr2lLI2k0lI5yE2vV/e0fUhbuwbe991qEvjpkFBQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a87db32-537f-4940-a515-08d7dd856235
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 19:28:44.3476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M5p0wUKD9fyfVEbsWybNku0JgJV1JVWmu7N8Kbq28PVPKRYIqB6YFbtTDk12BKTKRYth5W168E8Zcf6WrbY3utbmnECBPiRYnK0RKUmOWcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0903
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Sunday, April=
 5, 2020 5:15 PM
>=20
> Since vmbus_chan_sched() dereferences the ring buffer pointer, we have
> to make sure that the ring buffer data structures don't get freed while
> such dereferencing is happening.  Current code does this by sending an
> IPI to the CPU that is allowed to access that ring buffer from interrupt
> level, cf., vmbus_reset_channel_cb().  But with the new functionality
> to allow changing the CPU that a channel will interrupt, we can't be
> sure what CPU will be running the vmbus_chan_sched() function for a
> particular channel, so the current IPI mechanism is infeasible.
>=20
> Instead synchronize vmbus_chan_sched() and vmbus_reset_channel_cb() by
> using the (newly introduced) per-channel spin lock "sched_lock".  Move
> the test for onchannel_callback being NULL before the "switch" control
> statement in vmbus_chan_sched(), in order to not access the ring buffer
> if the vmbus_reset_channel_cb() has been completed on the channel.
>=20
> Suggested-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/channel.c      | 24 +++++++-----------------
>  drivers/hv/channel_mgmt.c |  1 +
>  drivers/hv/vmbus_drv.c    | 30 +++++++++++++++++-------------
>  include/linux/hyperv.h    |  6 ++++++
>  4 files changed, 31 insertions(+), 30 deletions(-)
>=20

Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
