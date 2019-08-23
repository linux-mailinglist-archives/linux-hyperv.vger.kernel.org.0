Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B46E9BB9C
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2019 06:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbfHXEXH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 24 Aug 2019 00:23:07 -0400
Received: from mail-eopbgr820097.outbound.protection.outlook.com ([40.107.82.97]:4016
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbfHXEXH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 24 Aug 2019 00:23:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arEv4FG5fUI8BaQ0hpAibay/5mForhL0LyNu3bGLAKi9cAHtJ4VtzDSmoddMuANAPQj3uE4OYklH7djvIH0dp/bxTj+CqZedYeZIo6zLDi7rQFdDKLr3GkjxWGwjaSA7miepLGE45pZrW5LV+/dC+/q+8n8LdCYboKuAEN+aPR6NTZt9g9iv0eSmzlT8eIdGF0/zN6BWKC5vgW8uG6k8py5ceUfSbkZUH99E1AN5b44Fku5xK4cMGsVEItc+GsidkQwQcfbyzGjm3MqMcTbCMSfahqucStQgYZWeuDi7SfeQDLjM1wccXLpcDCeme0HmxmiScPs1MEpXub1MnNXHkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6M3t0C/yZOiWBcg8+GhsZgGG1CilhjLw2Pvaa90u5FI=;
 b=UlDqbCIj014+aHnHVVbedXsFO1+fkF+lpt+UiDPV+6cyh+JcYC9jZmgvS/OiCtsST0jrKhOmuCS7pcsGSOiN7n2+FFlkorkX1+KRd2nOWdiWmrHO6dsAPNQk6qvPlQBuXcF6WOs3rR/1e0GXliAV+lPy9x6M5jdpCr0JaQkvVaAsY80GnPgtKFDbc3S5U4Xp2KK/pKXqnEqAawMS76MNn4l0FvGh1fDyXEALRV3HoOjW2ZElac5/99bj54WV5p7tqWICkZKJYczO/fH4NMsgXHG4RugqrPKCFpZVLFvd7e0rAqLzC84YTlSyltMj7hSbuTR4a7PA+jiOSAsvhJWycQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6M3t0C/yZOiWBcg8+GhsZgGG1CilhjLw2Pvaa90u5FI=;
 b=Ufo2pF60WPVEKCzVxZa8k5iHUKA7IiCgEric31Br1bLPppVKthuRo7JQNqlbJedE0prqG0KL7NweGIdJKwOx8Nfo8QTkSWJ7LJBM55zSKWBoFxzqqAOrZQgOslVage73HUo4WDQCDli5zniwmuZuoCc79xuiOlKcTY1fkGCWbZA=
Received: from MWHPR21MB0861.namprd21.prod.outlook.com (2603:10b6:300:77::15)
 by MWHPR21MB0861.namprd21.prod.outlook.com (2603:10b6:300:77::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.11; Sat, 24 Aug
 2019 04:23:04 +0000
Received: from MWHPR21MB0861.namprd21.prod.outlook.com (2603:10b6:300:77::15)
 by MWHPR21MB0861.namprd21.prod.outlook.com (2603:10b6:300:77::15) with
 TransportReplication id Version 15.20 (Build 2220.11); Sat, 24 Aug 2019
 04:23:04 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::8985:a319:f21:530e]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a%8]) with mapi id 15.20.2220.000; Fri, 23 Aug 2019
 19:51:57 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 06/12] Drivers: hv: vmbus: Add a helper function
 is_sub_channel()
Thread-Topic: [PATCH v3 06/12] Drivers: hv: vmbus: Add a helper function
 is_sub_channel()
Thread-Index: AQHVVvnd1/zp+soxM0mbE8pOD/myQKcJKiqA
Date:   Fri, 23 Aug 2019 19:51:57 +0000
Message-ID: <DM5PR21MB01375EFE9F76EDED7CC96F95D7A40@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <1566265863-21252-1-git-send-email-decui@microsoft.com>
 <1566265863-21252-7-git-send-email-decui@microsoft.com>
In-Reply-To: <1566265863-21252-7-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-23T19:51:55.3399838Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=df67a566-7186-471d-8c67-4185fd91456e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR21MB0861:|MWHPR21MB0861:|MWHPR21MB0861:
x-ms-office365-filtering-correlation-id: 871e8440-a0ef-4a6c-5baa-08d728035b19
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MWHPR21MB0861;
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB08615C0F9AA99CB7580F824AD7A70@MWHPR21MB0861.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0139052FDB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(199004)(189003)(10090500001)(74316002)(305945005)(66066001)(52536014)(14454004)(7736002)(486006)(6436002)(53936002)(476003)(229853002)(1511001)(446003)(26005)(256004)(14444005)(102836004)(9686003)(11346002)(186003)(2906002)(8990500004)(55016002)(81156014)(81166006)(478600001)(64756008)(66556008)(22452003)(2201001)(76176011)(66946007)(71190400001)(71200400001)(66476007)(7696005)(86362001)(52396003)(76116006)(6506007)(6246003)(2501003)(5660300002)(33656002)(8936002)(3846002)(6116002)(10290500003)(25786009)(316002)(110136005)(99286004)(4326008)(66446008)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0861;H:MWHPR21MB0861.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: W01ku238fVBf84v5LeyRt+Cau/t/6PdOYRsD+VoSVF4P4elk596AFqETP4AXkRsynAK97Do6Pb3Nbmzz0keQx0p6VqGHB6EcO97vUZ1Ggp1is94so5M/aBv3o7ggwlI+MFooAANmXC4zri8lpu3Ztiq6TM0QGKIElyLgalObs/md6Ylhn2XOEb1hAnQFFoR/KS7ZodGOmClJYEA1jXFzE1beojPFA4Yr2Dxuxfu1Lkb5myRIh7Ud/yb9KxN2thuhSwc49NzSnzt0T33LCuPPLJPNxxB8XTUso05aDug35tuteZ/IDBe/J48dJJD8yGVw2ncah35T5dNEyWQOasPA41X/xs3asxPxpSEQ4xzM/TkjAx15JLEorfW4gsCCQ98OPmXysvfa53D0fEQ+MQpY3jS0YfWv7zTy8ZmBvmslyCY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 871e8440-a0ef-4a6c-5baa-08d728035b19
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 19:51:57.1907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BTjFPLZQi4q5YiFJwrsgNaE12Hi+i/iBRcRCqwikyEWfTYL+r1pEhQZ88N10KkkbIJBUY4QaQhxTcNzhX/ltmqEL1ZYIJo+VELVEdG0jcEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0861
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Monday, August 19, 2019 6:52 P=
M
>=20
> The existing method of telling if a channel is sub-channel in
> vmbus_process_offer() is cumbersome. This new simple helper function
> is preferred in future.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  include/linux/hyperv.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 6256cc3..2d39248 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -245,7 +245,10 @@ struct vmbus_channel_offer {
>  		} pipe;
>  	} u;
>  	/*
> -	 * The sub_channel_index is defined in win8.
> +	 * The sub_channel_index is defined in Win8: a value of zero means a
> +	 * primary channel and a value of non-zero means a sub-channel.
> +	 *
> +	 * Before Win8, the field is reserved, meaning it's always zero.
>  	 */
>  	u16 sub_channel_index;
>  	u16 reserved3;
> @@ -934,6 +937,11 @@ static inline bool is_hvsock_channel(const struct vm=
bus_channel
> *c)
>  		  VMBUS_CHANNEL_TLNPI_PROVIDER_OFFER);
>  }
>=20
> +static inline bool is_sub_channel(const struct vmbus_channel *c)
> +{
> +	return c->offermsg.offer.sub_channel_index !=3D 0;
> +}
> +
>  static inline void set_channel_affinity_state(struct vmbus_channel *c,
>  					      enum hv_numa_policy policy)
>  {
> --
> 1.8.3.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

