Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56DEC11C829
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Dec 2019 09:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfLLIY2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Dec 2019 03:24:28 -0500
Received: from mail-eopbgr1300129.outbound.protection.outlook.com ([40.107.130.129]:22542
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728270AbfLLIY1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Dec 2019 03:24:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4Md8h0mMUfJKRveZyw0KHP07oPuKJcamDTLXlW0oRcz2uNv+i8xVL2YZ0Yq+zz1+ndGgBNCrP8r2KCjAGl1weUHq1FrbsNgjuBbgpZ/wSOILc+vyAZqVudsnAjHQwGbP+ZhcD3wsQr99uJAGSyxcum1V7IeFmQSbSEUiup5g833W2F7RrqcDkP+bRaipRwbZHvHV+50GwEvu2w3BckijbHdNAgP7WoP2IkeN+OrHPnh9Ci4cmbonR6kXslOGqX/ohYtMa9pNPGIKMCj/x37Ua8szvG4qDeZH0y/GuRFcHnlVCRWAAPEOSEYSvKgAXUXZLZJ3B8CC7TXT9hV8zAX+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vSGZHAwjerDdd8ZpBXiH7g0Q41bL1LDWA0sX3fVoxE=;
 b=XWDmOl4FRqOv/JGDdh9+gYQtNyBRqZhqWYPrk06rwnXTvpmabOizd8GckPHt6pwwrnDPnkW9NbHyfmvCcBIGW0UTdSpx5lhdIVN2NMrgoUKjkPaQTuljzoQsLSXqqbBY0w9qMsqHmfIYachXVf6FLNlQyFSEXsHjLkhkMXAiqv62M7TTd18y9cm/VBb4ocHIebzGi53/TWLrT6s5wkd1lLEXsSfJUXpaWRaZ/Bcnycgs14T+2cKvjRavA+7yfoSBy2iwf0d6czJhK4fM89c3S99G+5WaKjcutCHZXUN7sIR5mUPeZjP50/a87EdRnSuC2aDcwGwjabDCywLNDMpWUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vSGZHAwjerDdd8ZpBXiH7g0Q41bL1LDWA0sX3fVoxE=;
 b=EkN3XCVayGOqu7v3Kq0XYr+DwG6BLW6zMuzhP+YofnOdWtJ3alV1YgxohDd6p1Ucz6c4impksrPHgQc6nSfGG9w8PZLgrsmeWL86u/7zjZ+11gAMoeuR4ty5hEuUlZhgkTxukjOpav/G/EmvZAY+HmiRY+E3FcbQoHDRp0e5V9M=
Received: from PS1P15301MB0346.APCP153.PROD.OUTLOOK.COM (10.255.67.139) by
 PS1P15301MB0345.APCP153.PROD.OUTLOOK.COM (10.255.67.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.0; Thu, 12 Dec 2019 08:24:18 +0000
Received: from PS1P15301MB0346.APCP153.PROD.OUTLOOK.COM
 ([fe80::c5bb:5af:a6b6:9f2d]) by PS1P15301MB0346.APCP153.PROD.OUTLOOK.COM
 ([fe80::c5bb:5af:a6b6:9f2d%7]) with mapi id 15.20.2559.008; Thu, 12 Dec 2019
 08:24:18 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>,
        "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eric.devolder@oracle.com" <eric.devolder@oracle.com>
Subject: RE: [EXTERNAL] Re: [RFC PATCH 3/4] Hyper-V/Balloon: Call add_memory()
 with dm_device.ha_lock.
Thread-Topic: [EXTERNAL] Re: [RFC PATCH 3/4] Hyper-V/Balloon: Call
 add_memory() with dm_device.ha_lock.
Thread-Index: AQHVsDNJjhlisRM1nUS25YM4WFt2Tqe2KWOA
Date:   Thu, 12 Dec 2019 08:24:18 +0000
Message-ID: <PS1P15301MB03469867575D76C2C8977AB192550@PS1P15301MB0346.APCP153.PROD.OUTLOOK.COM>
References: <20191210154611.10958-1-Tianyu.Lan@microsoft.com>
 <20191210154611.10958-4-Tianyu.Lan@microsoft.com>
 <87pnguc3ln.fsf@vitty.brq.redhat.com>
In-Reply-To: <87pnguc3ln.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=tiala@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-12-12T08:24:13.0861288Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fd7516c9-1daa-4b92-9e4c-17e8a0ab05a2;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [167.220.255.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d48fe011-8ea1-410a-6a1c-08d77edcaec5
x-ms-traffictypediagnostic: PS1P15301MB0345:|PS1P15301MB0345:|PS1P15301MB0345:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PS1P15301MB0345AD072E00784747A5464F92550@PS1P15301MB0345.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(136003)(366004)(199004)(189003)(81166006)(81156014)(8676002)(8936002)(7696005)(10290500003)(71200400001)(6636002)(33656002)(66556008)(64756008)(66946007)(66476007)(52536014)(66446008)(26005)(54906003)(9686003)(110136005)(186003)(8990500004)(478600001)(316002)(55016002)(4326008)(86362001)(5660300002)(6506007)(76116006)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:PS1P15301MB0345;H:PS1P15301MB0346.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2ps7vlrsb5xBXsbAPoa8Sg+QEurwG4VBr3HAdaPtrjYTwJd7h+/a7f3XBoz9Ku8TKZG7ELq6YUmFO6QHlv0D5knnYQzrhHsG1tmCdPWCQ1OcLlAx3rJTpHMPEhariKIDm7K+fgyuDStaMo6OLBZnLVAgCnnK8Orlt8dr1uUQzEhaysdxLgONk3jlqqIBkNxG7I6azvk5rvGTcoYVdSnmmKtA/1AAoUZglf+2aiEYixypZJRILbrxCTkFBEgif1yC17y3mfrfkD0YmhmeZzkcDvxn1yCBh9T/97RJVw5lkSvPa1B6brdbu1jUi6S1KL+hDyeghwBxH2bo+rlDiWfUaE2ZGQ3hvUW7x8dP2TO9o+rm5Qlm70dK0ZUhoTc2BluSXEcesOZq6HZnQ+sTRa+vJDs/IFRZwnQPmiRPhBYxNEcy8/m+NXOgpSoMm8LGTCXP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d48fe011-8ea1-410a-6a1c-08d77edcaec5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 08:24:18.2355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: imjxGrHBLF6S2++oQaNHVOhZj81n5WBHuVAuurkQuzui1bcaReROZvRZmPxaefZ2ATE/8tS/DrXYNeNoBwFqqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1P15301MB0345
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Vitaly:
	Thanks for your review.
> From: Vitaly Kuznetsov <vkuznets@redhat.com>=20
> > From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> > @@ -771,8 +767,13 @@ static void hv_online_page(struct page *pg,
> unsigned int order)
> >  	struct hv_hotadd_state *has;
> >  	unsigned long flags;
> >  	unsigned long pfn =3D page_to_pfn(pg);
> > +	int unlocked;
> > +
> > +	if (dm_device.lock_thread !=3D current) {
>=20
> With lock_thread checking you're trying to protect against taking the spi=
nlock
> twice (when this is called from add_memory()) but why not just check that
> spin_is_locked() AND we sit on the same CPU as the VMBus channel
> attached to the balloon device?

Yes, that's another approach.
>=20
> > +		spin_lock_irqsave(&dm_device.ha_lock, flags);
> > +		unlocked =3D 1;
> > +	}
>=20
> We set unlocked to '1' when we're actually locked, aren't we?

The "unlocked" means ha_lock isn't hold before calling hv_online_page().

>=20
> >
> > -	spin_lock_irqsave(&dm_device.ha_lock, flags);
> >  	list_for_each_entry(has, &dm_device.ha_region_list, list) {
> >  		/* The page belongs to a different HAS. */
> >  		if ((pfn < has->start_pfn) ||
> > @@ -782,7 +783,9 @@ static void hv_online_page(struct page *pg,
> unsigned int order)
> >  		hv_bring_pgs_online(has, pfn, 1UL << order);
> >  		break;
> >  	}
> > -	spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> > +
> > +	if (unlocked)
> > +		spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> >  }
> >
> >  static int pfn_covered(unsigned long start_pfn, unsigned long
> > pfn_cnt) @@ -860,6 +863,7 @@ static unsigned long
> handle_pg_range(unsigned long pg_start,
> >  		pg_start);
> >
> >  	spin_lock_irqsave(&dm_device.ha_lock, flags);
> > +	dm_device.lock_thread =3D current;
> >  	list_for_each_entry(has, &dm_device.ha_region_list, list) {
> >  		/*
> >  		 * If the pfn range we are dealing with is not in the current
> @@
> > -912,9 +916,7 @@ static unsigned long handle_pg_range(unsigned long
> pg_start,
> >  			} else {
> >  				pfn_cnt =3D size;
> >  			}
> > -			spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> >  			hv_mem_hot_add(has->ha_end_pfn, size, pfn_cnt,
> has);
> > -			spin_lock_irqsave(&dm_device.ha_lock, flags);
>=20
> Apart from the deadlock you mention in the commit message, add_memory
> does lock_device_hotplug()/unlock_device_hotplug() which is a mutex. If
> I'm not mistaken you now take the mutext under a spinlock
> (&dm_device.ha_lock). Not good.

Yes, you are right. I missed this. I will try other way. Nice catch. Thanks=
.

>=20
>=20
> >  		}
> >  		/*
> >  		 * If we managed to online any pages that were given to us,
> @@
> > -923,6 +925,7 @@ static unsigned long handle_pg_range(unsigned long
> pg_start,
> >  		res =3D has->covered_end_pfn - old_covered_state;
> >  		break;
> >  	}
> > +	dm_device.lock_thread =3D NULL;
> >  	spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> >
> >  	return res;
>=20
> --
> Vitaly

