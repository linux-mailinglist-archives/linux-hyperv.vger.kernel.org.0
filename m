Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8C9A423D
	for <lists+linux-hyperv@lfdr.de>; Sat, 31 Aug 2019 06:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbfHaEhb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 31 Aug 2019 00:37:31 -0400
Received: from mail-eopbgr1320090.outbound.protection.outlook.com ([40.107.132.90]:15614
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbfHaEhb (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 31 Aug 2019 00:37:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlHuC3nOHbpEl4gwQZQirP/vi/m979lh7hW8BbaYKo8O7IuAOqdizFzRAiOLs3FelMdpXhl4yAkeXL9KmxcrpYGAC8pFP2+GDjmiHHzeD2C5y6f7sdsq3vSCt8aPodLOIFLgt7hUTScJwmT8ahlQJj4pKvBtf8SdBU/EosdaSGeFPovW7AkgaORUHb31BV6oss8rfkfL62miEWTtDHcJKrub/zBgtGssoDrrWj+LXFBMJvHc7ewIp/4onOsgXdLrq47h8CEUqueekmMfk/Y1PQAtScM0yIbdL0X8GVdI0cTmuyE5kc1c3I1yh3TnIMx40+nOLKhc1Me+akNpoPLRew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KvsPc+Hvavab2WTycjhxbGxwjX+yYmpUlDey4rFh/0=;
 b=lGDwyuQAHlzflTgfPK7vh0XGr+eXTWeDBGF4vZrF/6J6IQCwWE/ccTNN2d6w3gk37G6ZvtMyibwhk5l+PraLAI/FNJCioNjGzdsdE7xms0s7611OxskgV8FWCBI8plB4iw7EHMZ08ylGPQcHTu8MV3a6WYnzXKAb8ywW1HO8AFPojEc/epc+oANZ73Dz/mtCUYorjr/5JvxNvvg+JDqn56EtozZg/FqyJFaXwOijN+YKAgOFbMVX4bjZS7tRuio2BvLeotGVZpyV7Ag/vz7TPzlNYpExawxuBwJz/VkHvvOyhUugewWBEtv8+hHdC5MX9uunVk3QN8VSs8T7vAsZbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KvsPc+Hvavab2WTycjhxbGxwjX+yYmpUlDey4rFh/0=;
 b=UrQaa9Ydh6gf2jGozJxHapKwpAREX8nsyg2UWa9oyadJ3cyYPs7ZYB5YHo2e6EZ6ziUYAWH5t6X7sBqKgtyYHHX6AnjYiIxvEmUKNbxE0LLUGxMyQ96Kezw4PzJHT5Mm7P+EJWWIfZZQpuBPe0uNIJ0d6+sKItnYWvrLz3E3ouQ=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0185.APCP153.PROD.OUTLOOK.COM (10.170.187.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.5; Sat, 31 Aug 2019 04:37:14 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3%4]) with mapi id 15.20.2241.006; Sat, 31 Aug 2019
 04:37:14 +0000
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
Subject: RE: [PATCH v3 12/12] Drivers: hv: vmbus: Resume after fixing up old
 primary channels
Thread-Topic: [PATCH v3 12/12] Drivers: hv: vmbus: Resume after fixing up old
 primary channels
Thread-Index: AQHVVvnhnZYV8iEJF0ORPS4BQ7lYm6cJMgUQgAty55A=
Date:   Sat, 31 Aug 2019 04:37:14 +0000
Message-ID: <PU1P153MB0169E3DD602FB575C346186DBFBC0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1566265863-21252-1-git-send-email-decui@microsoft.com>
 <1566265863-21252-13-git-send-email-decui@microsoft.com>
 <DM5PR21MB01370691E881D59773B9EF60D7A40@DM5PR21MB0137.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR21MB01370691E881D59773B9EF60D7A40@DM5PR21MB0137.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-23T20:25:01.1543000Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ed8325f3-7994-47a0-9ecc-2c1fc987ecca;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:5cbd:8ecd:62e5:20b7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b049200-4eb6-4dbb-20a8-08d72dcce5e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0185;
x-ms-traffictypediagnostic: PU1P153MB0185:|PU1P153MB0185:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB01858CF1DA91DE0173813F66BFBC0@PU1P153MB0185.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 014617085B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(199004)(189003)(446003)(25786009)(10090500001)(10290500003)(76176011)(46003)(6246003)(102836004)(2501003)(14454004)(52536014)(99286004)(478600001)(71200400001)(4326008)(71190400001)(7696005)(81166006)(110136005)(9686003)(8936002)(66556008)(22452003)(316002)(476003)(256004)(6506007)(5660300002)(55016002)(53936002)(6436002)(66446008)(66946007)(86362001)(1511001)(81156014)(6116002)(66476007)(186003)(74316002)(8676002)(2201001)(76116006)(64756008)(305945005)(229853002)(33656002)(11346002)(7736002)(486006)(2906002)(8990500004);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0185;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4w0bc7t9H5p6HWAYahh/wb9IWZUel7maG7AdAEE5uDWCgAFtaAx7Srw3bX0+o60BGreND+CY12NwEa1kQs5WjlkqsB/gWTNa+KEP3RprWFrIJGQWESy2nZe6FuPFZXe+C9+DW/MlgaPRUR90YK2laEYxlRR3JwxskAwALnx14gHsO3N9BHrgF1J00qUVsuAYbE4WW/9bEcrITUuH6qqqzRXf7FopSewPs6BBaunsQkJTHUobSl9gbI06R8sXuSrzDfhMC9nskiYNaRDj4ANjt6x7WWVFWmiYlnos2ouwJco9u2EuR0fhvSvT+mi175OXmUSUcom7IdwK5EoFNv+Yka7O8ZGArlSFE6+yRilNH2CEj9FStKJftok5zgSCwjua5aAD5sGM2c3kU5yswRe7smK7Nh7xbOFyMNgiiTrpAGQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b049200-4eb6-4dbb-20a8-08d72dcce5e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2019 04:37:14.5188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OXQraOrAgmugOlrcN4CU93WtkrvVt12mGRpW5C/zWKLfLgfINuIOBocJp1G2zLe2eHmFQsCONDZVqhqOI/WaBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0185
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Friday, August 23, 2019 1:25 PM
>=20
> From: Dexuan Cui Sent: Monday, August 19, 2019 6:52  PM
> > @@ -890,6 +937,11 @@ static void vmbus_onoffer(struct
> > vmbus_channel_message_header *hdr)
> >  				     false);
> >  		print_hex_dump_debug("New vmbus offer: ",
> DUMP_PREFIX_OFFSET,
> >  				     16, 4, offer, offer_sz, false);
> > +
> > +		vmbus_setup_channel_state(oldchannel, offer);
> > +
> > +		check_ready_for_resume_event();
>=20
> This is the error case where the new offer didn't match some aspect of
> the old offer.=20

Actually, this is not an error: besides the RELID, the host can also change
the offer->connection_id when it re-offers a device to the guest: so far,
I only see this host behavior for the VF vmbus device, and in this case, th=
e
first vmbus_setup_channel_state() in vmbus_onoffer() is used to do the
fix-up:
    channel->sig_event =3D offer->connection_id;
and later channel->sig_event is used in vmbus_set_event().

Despite the host behavior, it looks the VF vmbus device still works fine,
so (IMO) this is not an error. I'll write a separate email to report this t=
o
Hyper-V team.

> Is the intent to proceed and use the new offer?=20
Yes, since this is not an error.

I'll add a comment before the "Mismatched offer from the host" for this.

BTW, the 3 debug lines here output nothing, unless we enable the output
by=20
  cd /sys/kernel/debug/dynamic_debug/
  echo 'file drivers/hv/channel_mgmt.c +p' > control
.

> I can see that check_ready_for_resume_event() has to be called in
> the error case, otherwise the resume operation will hang forever, but=20
> I'm not sure about setting up the channel state and then proceeding as
> if all is good.
> > +
> > 		return;

Thanks,
-- Dexuan
