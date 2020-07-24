Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C54822CC93
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Jul 2020 19:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgGXRsS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 24 Jul 2020 13:48:18 -0400
Received: from mail-mw2nam12on2108.outbound.protection.outlook.com ([40.107.244.108]:1581
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726731AbgGXRsQ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 24 Jul 2020 13:48:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmTxNTg1gJJ7l+t4eofli8MMXANgDgq7HgfmboVrK+Jg2uHZozY9IwIEL+vVPghopW26HpziXVUxbWxL/yealCg6pyi9exo+EO4O0ZVJjrEgpSqx6cyAheSh0QhQsEH6Nnk45AE8cj9XJ6kWsbs4C6MpjSAIdlTe6RaqXLC641Cp5rUxJQFUBtzQVzSl26XBrjlWFJQLKwMX4pRJV5AoYUAK7p3G3bcL465KG6oHIk0vHKkitTKULqIJS+qTdoB6aHqyd316DM9Fu/FuCo3Lod/QAI09Ad74mq3DW5c3oyRD4Qqn/VMr/ZGdOOutN6dPfFvNZKd+WowocPvA4SqxxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXiSccFOo6otIu3zRZ2TJuYK1Nq/KQosYt56pQ1kCyk=;
 b=LpTkwl3A+4RZdZRAAfvtaSP9/3MYtRpJKTvvzZdSctmG74WYdulFh6Tm7GUyxJlrTl4GSl1pHyLgUHGtD7dEPVdoJOTnKhqxnIrHWuHPI4EVRAXMYgiLyjxGw/PG9t3Pny+eZAlpKVwRTkoPWGmTaq/0wgIpv+M6tXCOeg0ckHj53dvZXCnphJCCyGfreZjSdu4yyUrvb6ZRDFxb7WzhLBP8wt9UulpPtkm6XvgrJuyAjePVZ71LjpeKtDo63oFAovxsuFpj1y4tqHbtxQTQ27RPpRoCqdYD0uEH2E3MyXD4A8+/DVNHQ2BGmiMoWoGg74fUpW+iHy+Jfm33vtcSHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXiSccFOo6otIu3zRZ2TJuYK1Nq/KQosYt56pQ1kCyk=;
 b=N9gGRmQH4VK3CYtS5sIqgzuGR0lPuh6oYjtLrNQEpXZwT2loTaSAuR8R+NwZb9Bikf93bawVX9dOVYl4KZ5oDHxiHnn48XWRQcec1qa6fqPRmdfZ7lzhYuFB/q9wZ12k+Vyq7asY3LZzBBBhkFJSYBqJiF0kXsjmn5fAlOvBSV4=
Received: from BL0PR2101MB0930.namprd21.prod.outlook.com
 (2603:10b6:207:30::18) by MN2PR21MB1486.namprd21.prod.outlook.com
 (2603:10b6:208:1f7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.9; Fri, 24 Jul
 2020 17:48:13 +0000
Received: from BL0PR2101MB0930.namprd21.prod.outlook.com
 ([fe80::f5a4:d43f:75c1:1b33]) by BL0PR2101MB0930.namprd21.prod.outlook.com
 ([fe80::f5a4:d43f:75c1:1b33%5]) with mapi id 15.20.3239.011; Fri, 24 Jul 2020
 17:48:13 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Stephen Hemminger <stephen@networkplumber.org>,
        Andres Beltran <lkmlabelt@gmail.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        Saruhan Karademir <skarade@microsoft.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: Fix variable assignments in
 hv_ringbuffer_read()
Thread-Topic: [PATCH] Drivers: hv: vmbus: Fix variable assignments in
 hv_ringbuffer_read()
Thread-Index: AQHWYdnygalh4GYqZ06NpC1cNLe6jqkW9wqAgAAH5rA=
Date:   Fri, 24 Jul 2020 17:48:13 +0000
Message-ID: <BL0PR2101MB09303D51B6CC0DA2CE0A6782CA770@BL0PR2101MB0930.namprd21.prod.outlook.com>
References: <20200724164606.43699-1-lkmlabelt@gmail.com>
 <20200724101047.34de7e49@hermes.lan>
In-Reply-To: <20200724101047.34de7e49@hermes.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-07-24T17:48:12Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=25e3d78f-1e70-41de-b9bb-e257e2f97208;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: networkplumber.org; dkim=none (message not signed)
 header.d=none;networkplumber.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [75.100.88.238]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e60ec97-9b4e-4416-cd9c-08d82ff9bcd7
x-ms-traffictypediagnostic: MN2PR21MB1486:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR21MB148684B21B1595004A88F365CA770@MN2PR21MB1486.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5n8b0Ah+sOTnsebNAxn7XrjMLlelF0Y6MKWvzjAORutusrKK5WMitR4rPIRXsTNCnp9ltTVn1b09tx8wEOZdE2uLZd6zwFkMlIbm7jJ+P/vnFZTiFIJHRMXll0oTrEu3I/baJf8xjJ/rkXLGGJCyURvUUy46RDb+afNJX93ULoW0snY/I6AMnfH06UZdQPw4ySDy2BBXK5YlM3Hoyg8ZwHN0+uqil/L6W8FdZQ0TFzFFn0M2B5kgcPRnKtbzXpV5aNjiep3/2b7I2L7KrT1wusTMPW/RE/6Oyb4GFI+JCKvFA8TUh7CaTOJ71IU7DgtTVIVeSu+pXnosHfxU1USKgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB0930.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(83380400001)(82960400001)(54906003)(5660300002)(6506007)(110136005)(76116006)(71200400001)(26005)(4326008)(86362001)(7696005)(316002)(2906002)(82950400001)(186003)(66476007)(66446008)(66946007)(64756008)(66556008)(53546011)(8936002)(8990500004)(52536014)(478600001)(107886003)(33656002)(9686003)(55016002)(8676002)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: qpxETa/Fx00jxpp2usN8XJfnV0aa6rme1Ud2Y6E8OQG6aOb/UjPmTCBfsEKUWCFsefJsF20IGr/FyK+0WzeFu9abRAlHLEUvi5NtU0hYraKU7wODS8Nf5lbKIxHwLY1Vd8Ht2jmM2SU84C0XLDq/HfkDhA7lLQpTH5nxE4Pb5KVwtaVfLohYAs/MsX8aVJ9wvEinhTrLPl8y+wGo8jFER12kWD4cP2g9faZqO5f0Mr1BZZ13Y1Rkhe6unHhwAjKEuo0cz0m2ZL5+Gn/6m21z3NbV7u0EcqpRasXiH/5SsyALDiZohs+wOb8udYZd0ovm1rUQUC2VXVLvx7qB+6PgJrXdxOlN7ix5Et7Ams5oTw9k5dvTRIgGaxDIfc6YObs8zoZfgdUDWVAqDaeG+rR/QgFyFjhYsyN1hlloIdey2l2sxjd96GadQHWBN5qF3OQXcui4dsK/WwB+n82b9HiRoeLVqpHpmhhmF0NCeDTLUuLTDo7gETQTcCqBllcyvwTULrpDYuxoeDsoLKZ6/v4B9rou6d5EZCFhtvhwPhOZrxmOieT25H8wosbao42w0fd/iBj1sU6aZ3CqVTFQcUDZb0W6J9Q3PG50/eggaodbeMOV7u7Gy69frTg8gGmYz/AKgsM4OAcR3SQOFDf4+Sdb/w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB0930.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e60ec97-9b4e-4416-cd9c-08d82ff9bcd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2020 17:48:13.3207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9TambnX2Z1zQ9rC4emlLmANbowfvn5MzULI2mIBd1Xp0XAi6RONfusujyC/wXKAS8b/gcQurM35zGbImyKlUWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1486
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Friday, July 24, 2020 1:11 PM
> To: Andres Beltran <lkmlabelt@gmail.com>
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> wei.liu@kernel.org; linux-hyperv@vger.kernel.org; linux-
> kernel@vger.kernel.org; Michael Kelley <mikelley@microsoft.com>;
> parri.andrea@gmail.com; Saruhan Karademir <skarade@microsoft.com>
> Subject: Re: [PATCH] Drivers: hv: vmbus: Fix variable assignments in
> hv_ringbuffer_read()
>=20
> On Fri, 24 Jul 2020 09:46:06 -0700
> "Andres Beltran" <lkmlabelt@gmail.com> wrote:
>=20
> > Assignments to buffer_actual_len and requestid happen before packetlen
> > is checked to be within buflen. If this condition is true,
> > hv_ringbuffer_read() returns with these variables already set to some
> > value even though no data is actually read. This might create
> > inconsistencies in any routine calling hv_ringbuffer_read(). Assign val=
ues
> > to such pointers after the packetlen check.
> >
> > Signed-off-by: Andres Beltran <lkmlabelt@gmail.com>
> > ---
> >  drivers/hv/ring_buffer.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> > index 356e22159e83..e277ce7372a4 100644
> > --- a/drivers/hv/ring_buffer.c
> > +++ b/drivers/hv/ring_buffer.c
> > @@ -350,12 +350,13 @@ int hv_ringbuffer_read(struct vmbus_channel
> > *channel,
> >
> >  	offset =3D raw ? 0 : (desc->offset8 << 3);
> >  	packetlen =3D (desc->len8 << 3) - offset;
> > -	*buffer_actual_len =3D packetlen;
> > -	*requestid =3D desc->trans_id;
> >
> >  	if (unlikely(packetlen > buflen))
> >  		return -ENOBUFS;
> >
> > +	*buffer_actual_len =3D packetlen;
> > +	*requestid =3D desc->trans_id;
> > +
> >  	/* since ring is double mapped, only one copy is necessary */
> >  	memcpy(buffer, (const char *)desc + offset, packetlen);
> >
>=20
> What is the rationale for this change, it may break other code.
>=20
> A common API model in Windows world where this originated
> is to have a call where caller first
> makes request and then if the requested buffer is not big enough the
> caller look at the actual length and allocate a bigger buffer.
>=20
> Did you audit all the users of this API to make sure they aren't doing th=
at.

I took a quick look. I saw a case which treats the ringbuffer_read as=20
successful if the buffer_actual_len > 0. So if hv_ringbuffer_read() should=
=20
not be fixed this way, then all callers like balloon_onchannelcallback()=20
need a fix.

1476 static void balloon_onchannelcallback(void *context)
1477 {
1478         struct hv_device *dev =3D context;
1479         u32 recvlen;
1480         u64 requestid;
1481         struct dm_message *dm_msg;
1482         struct dm_header *dm_hdr;
1483         struct hv_dynmem_device *dm =3D hv_get_drvdata(dev);
1484         struct dm_balloon *bal_msg;
1485         struct dm_hot_add *ha_msg;
1486         union dm_mem_page_range *ha_pg_range;
1487         union dm_mem_page_range *ha_region;
1488
1489         memset(recv_buffer, 0, sizeof(recv_buffer));
1490         vmbus_recvpacket(dev->channel, recv_buffer,
1491                          HV_HYP_PAGE_SIZE, &recvlen, &requestid);
1492
1493         if (recvlen > 0) {
1494                 dm_msg =3D (struct dm_message *)recv_buffer;
1495                 dm_hdr =3D &dm_msg->hdr;

Thanks,
- Haiyang

