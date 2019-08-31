Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B403CA414D
	for <lists+linux-hyperv@lfdr.de>; Sat, 31 Aug 2019 02:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfHaAYh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 30 Aug 2019 20:24:37 -0400
Received: from mail-eopbgr1320128.outbound.protection.outlook.com ([40.107.132.128]:35280
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727708AbfHaAYg (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 30 Aug 2019 20:24:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IT/096RlYKhhmkrpLRbpG+8a6cfXkFxikRJ4fNZ5Q9vSCxloT4z/MHfM/scl6YcF8lm7rcvi7+y02cs78NwR58HCN5jlZDCsuZ8qdPemz8KzSfzKM160H3VAtpPd1S4pbD9dONYOmBzMmW3mGB4PjXL7nlR9ykKR/LIwt+RaHSbNrTNulNv39N+JKrAiz/m+QKbuE9H55cX0cDPVmgPzv1Fwdg2Rd6aVotP5QSvO9UDQvA1PXE/a0Pb97GGoQxQZDnb9V3qMv+eLP59b4s2yaiYPZE0WXrdX4C1PfT1z6DI3IwE/wZfMR5k5DrMLDsd9RsVb/9MgX8yc5LUImGvAFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uvJgc4rvO3h0faUYhNZS7FKAVOrKUg+K0QMalayAwY=;
 b=QAgOlmgOTEKxhC39hnJxphx/6T3JtvW8VixG4zXHUrT0BJazJVoimM5PNu4YPRcr/iwHAVZ6irAyzRT1qABCM7p0sJRJU2uUpQ/tLT5/XVSxUCvpp9u4zegVIZG7zEYb5cGYPkiSrEgI7Wpkw46RqD+/QyXXKsg1zgbLbMcM80ztpVNe1AE5qVmtwruVGMQ8vZtH4/pvpwOGjrDwwUMoMkrBzaQyBL1xFKhcDHiHSuRfPG9fUISOTa1XsYi9DlexXfDwomthYGnFdXIzNcTHdppxLQvQ9cnpX3aZ82nfUGvHYAEDysKYbkwLATAbH3wzjL1/JVmYlC2aUTjeSslKSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uvJgc4rvO3h0faUYhNZS7FKAVOrKUg+K0QMalayAwY=;
 b=Y//j2uMTIk2ESFQb+a81iaAWCreTtF8pkNMK0TlLXT0+nvvmyk43VlyJVFr5ddzaAiPRXBeewlAQNnwjanuNTylBjCEyoXQike8Yuych1DnsJlZQWpLXGIV2VTTLGRAU8gU03vVCdSWxrPKR/HowMJ38Km2aKY5aqmyz2b2MV5s=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0124.APCP153.PROD.OUTLOOK.COM (10.170.188.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.3; Sat, 31 Aug 2019 00:23:49 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3%4]) with mapi id 15.20.2241.006; Sat, 31 Aug 2019
 00:23:49 +0000
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
Subject: RE: [PATCH v3 08/12] Drivers: hv: vmbus: Ignore the offers when
 resuming from hibernation
Thread-Topic: [PATCH v3 08/12] Drivers: hv: vmbus: Ignore the offers when
 resuming from hibernation
Thread-Index: AQHVVvnez8f5+ZNs+0+5s8sO4QKl7KcJKo+wgAtLSZA=
Date:   Sat, 31 Aug 2019 00:23:49 +0000
Message-ID: <PU1P153MB01691DCFF28612DFCA852401BFBC0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1566265863-21252-1-git-send-email-decui@microsoft.com>
 <1566265863-21252-9-git-send-email-decui@microsoft.com>
 <DM5PR21MB01375F5A46E46079DA611622D7A40@DM5PR21MB0137.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR21MB01375F5A46E46079DA611622D7A40@DM5PR21MB0137.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-23T19:56:42.9471406Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e21d423b-8579-4709-963a-79ab2ea4258c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [131.107.159.158]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32cc424d-1830-4473-a6d6-08d72da97ec2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0124;
x-ms-traffictypediagnostic: PU1P153MB0124:|PU1P153MB0124:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB012487D6E8C1FE09CA65CAE4BFBC0@PU1P153MB0124.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 014617085B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(189003)(199004)(9686003)(33656002)(26005)(14454004)(66946007)(66476007)(66556008)(66446008)(64756008)(76116006)(10290500003)(476003)(102836004)(7736002)(25786009)(4326008)(10090500001)(305945005)(11346002)(55016002)(6506007)(53936002)(446003)(110136005)(74316002)(229853002)(6246003)(2501003)(186003)(22452003)(486006)(86362001)(66066001)(2201001)(81156014)(81166006)(14444005)(5660300002)(256004)(1511001)(8936002)(8990500004)(498600001)(6116002)(3846002)(8676002)(6436002)(52536014)(71190400001)(71200400001)(2906002)(99286004)(76176011)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0124;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IMJoOT9uS20ZTH01WJmsfmQXsOgzJ9o0PC3rsszfPYkw/RxEoi7re8umHD0PqVYPzzfxVuqL75tKDw6c9dymUKquRSOK+XdGVHHoylMSeyREQk8GNlaReF2oauRWK64m55UslzYFz9NG+WtNILeKfx9GOYrrUftr977K9dh0j5JPOtODAWh7hdwEfYR0U7E1J2EpW1Y9w1Zzs6ZJduW1R5KBubVvwPNI4raAla16L4VRiDD/kopvnh/vtRucjSYmpvjhr0c4EZlDiFWflWvnUlLQTqVPMJX0ee5lfIdGyCd71uLVXmSALajt//bvjkB1Z94ztp6yj/0xk5xKkl8L0V1x8MOLDA2zkjFp4TgEjOZuWSW8E8yWnpwgmhtRwv3ftHRp9f3GrTcs+S9+Yl/LxX3aQKrbX6Fy0MlJjXZYYIQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cc424d-1830-4473-a6d6-08d72da97ec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2019 00:23:49.2135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uJQNavORUBm3T8RVZ5HnYgeSWUXB8q8p9ULrk+s8vd7mLAAgNEUWuoVLOXiT8JnAnj8hthn69uU5/H79oSf1Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0124
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Friday, August 23, 2019 12:57 PM
>=20
> From: Dexuan Cui <decui@microsoft.com>  Sent: August 19, 2019 6:52 PM
> >
> > diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> > @@ -337,6 +337,33 @@ struct vmbus_channel *relid2channel(u32 relid)
> >  }
> >
> >  /*
> > + * find_primary_channel_by_offer - Get the channel object given the ne=
w
> offer.
> > + * This is only used in the resume path of hibernation.
> > + */
> > +struct vmbus_channel *
> > +find_primary_channel_by_offer(const struct vmbus_channel_offer_channel
> *offer)
> > +{
> > +	struct vmbus_channel *channel;
> > +	const guid_t *inst1, *inst2;
> > +
> > +	WARN_ON(!mutex_is_locked(&vmbus_connection.channel_mutex));
> > +
> > +	/* Ignore sub-channel offers. */
> > +	if (offer->offer.sub_channel_index !=3D 0)
> > +		return NULL;
> > +
> > +	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
> > +		inst1 =3D &channel->offermsg.offer.if_instance;
> > +		inst2 =3D &offer->offer.if_instance;
> > +
> > +		if (guid_equal(inst1, inst2))
> > +			return channel;
> > +	}
> > +
> > +	return NULL;
> > +}
>=20
> Any particular reason this new function is in connection.c instead of
> putting it in channel_mgmt.c where it is called?

There is a similar function relid2channel(), which is in connection.c.

Since the new function is only used in channel_mgmt.c. I'll move it to
channel_mgmt.c in v4.

Thanks,
-- Dexuan
