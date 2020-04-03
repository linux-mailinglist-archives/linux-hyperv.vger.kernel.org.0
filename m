Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56EBC19CE6C
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2020 03:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389477AbgDCB40 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 2 Apr 2020 21:56:26 -0400
Received: from mail-eopbgr750095.outbound.protection.outlook.com ([40.107.75.95]:9444
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388709AbgDCB40 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 2 Apr 2020 21:56:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNVuLRcOiDslAeY1Wm1TNKFhSue/bG2WlHgu0Xx/JglwIcHXevgocbNZ4PEn6/dIPNccUbdPiCcVrkdgsDDswyoY25kr5hZkRJqI1vYmpXkilcC0P+bsoXfDd9QZ006TUxqZdThq89r0gbL9kmd+ZTSqWC8D976t4/Q5JDkZzun/PWbXEytGffUWBj8v/yCAcr0kZMx1DuTXAprLQKrOXNUMQlnk2H2aOanUx5Z1Py/uSAaG9fAjGu5BFUVk4lKrhEYqTxGYLHq4ddD4twgDgAHSMpxGqS3IWphTTYr1PYrZiqZjmjeF17ixpPsdjht7ey4s+5qJsSCjmGUg4PKt6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzztQwNwJKQr/aLnkVjxzlsXej5Ah3AIKJCUkhJhz3U=;
 b=eGWRJ62Ne/NbXIOa0UCsFaQyyoKoEZOfXW67OQGHOHRE9ei2RAfeeorxsYANWgKR5bUqOsjzSn8c948jgGnV2wuwtLrXTD0fNmW7ndIHcRYquQK9foZYEHGCGnbpuUg/YTgNnJttjcAe7jhMh/FrSAEPJU6N8RbUdL3XhJCSVIxClVXgAoY+/I6l+sf4eEbv8NdFiw762DyGkuwYBDA3PsR0Qgy9KVXp3qb5aIfdvwH8xK1otw0T5onGBu/90iqSUVyCsyW7REMKQPl7f5AJHk7oVj2HTgRlrF6fUH2FDF6dgfXMTXuNxJEGg+d1wvr9DG39JDjsDFA+8eEt6nNMVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzztQwNwJKQr/aLnkVjxzlsXej5Ah3AIKJCUkhJhz3U=;
 b=bEpJdU0pp6ooYuopS8yP1IT3ncxAVg2a4KzEZMT/ojT9eCzjQhQ1ts1Bx2w8tbVO3NaRiDjQXhUrV38uXo6vK5NsiptlS+el0mf1WfwpxjUesodqHpsTec7lhlTC4Suy6UTVNQaVS6FTUg5Y0DAtiv+cNJ+jtIhhrh43DLp76yI=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0938.namprd21.prod.outlook.com (2603:10b6:302:4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.2; Fri, 3 Apr
 2020 01:56:20 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%9]) with mapi id 15.20.2900.002; Fri, 3 Apr 2020
 01:56:20 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: RE: [PATCH 4/5] Drivers: hv: make sure that 'struct
 vmbus_channel_message_header' compiles correctly
Thread-Topic: [PATCH 4/5] Drivers: hv: make sure that 'struct
 vmbus_channel_message_header' compiles correctly
Thread-Index: AQHWCBGqfv/Ouhs2ikWLncMIhXoP36hmpceg
Date:   Fri, 3 Apr 2020 01:56:20 +0000
Message-ID: <MW2PR2101MB1052AB02CB74E0D165409344D7C70@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200401103638.1406431-1-vkuznets@redhat.com>
 <20200401103816.1406642-1-vkuznets@redhat.com>
In-Reply-To: <20200401103816.1406642-1-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-03T01:56:19.1734243Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ab8c8a82-54f4-48ac-9795-40da4e86bd87;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7873dc08-a486-486f-e1c5-08d7d77234cd
x-ms-traffictypediagnostic: MW2PR2101MB0938:|MW2PR2101MB0938:|MW2PR2101MB0938:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB0938E76C6BBFA7C5209614F0D7C70@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:541;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(6506007)(10290500003)(110136005)(54906003)(82960400001)(33656002)(7696005)(316002)(478600001)(8936002)(82950400001)(81156014)(55016002)(8676002)(81166006)(66946007)(186003)(9686003)(4326008)(4744005)(66556008)(66476007)(64756008)(71200400001)(8990500004)(76116006)(26005)(86362001)(2906002)(52536014)(5660300002)(66446008);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xLvLhOcuwIXIjnwK+kReiDLoc+oz9VtE8TcE7qvLb/6RageNu6Ks7t7hpXe/GXhmQpJJSnPhffkKZBq+bPjYxVBZV8OjETKzMpJ7PXyktQfKKN0+q5FmVsxireXZI6fbKKoF9EbNnYk24XzT/tM65h04SV4j5HoMIlXjxxo9/rcGuASbuQHM4tSFlhkxLh8e/rrrYg7VtjTm5Aqb8zLdAmUKK9uXqbJUaYYlp/ZRzUAUUjEUtois7rQzRCEVsSU1jP0FIaDY2BLPtm261Ud2sh8Z1DVcEQCFS0IHt/Ftso2JLd5DsWXMRYnulKkkSHXfpdZgkPj/U4TYaaCuSlDeHLjuQ0kghpiyOiWTTJ/ReZMtCON4M/UoWimlIhs+wmvkpkQG7svhag3qFllHEik4NIZdZCk0j6pUpeoQ1+OBUJqndtvITVMGvHOzDvGZ1ouk
x-ms-exchange-antispam-messagedata: ioq6ASdij49zp9WAuGg5nQZ+yKBYFuoOXLCWtBCP2X+eT6NZ42enKrejeC8f3EXNaMtP4nxJuAnS2G34dWtPKbVw7a1HS42UA7y6HrOz+fwArbz3o2hI6Fs+r2/8e8EaM95+nPPeUA4UlbYnLNGENw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7873dc08-a486-486f-e1c5-08d7d77234cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 01:56:20.6816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AJ/zLiYngrJCFDRER6H2oHjST6JdZgUhcOx2W1W+itBNZzxnmzTx8eLFci4jxqu75/lN7zqnGfVziES6qw7qCm2xfPv05MSv5zfCCaoSZwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Wednesday, April 1, 2020=
 3:38 AM
>=20
> Strictly speaking, compiler is free to use something different from 'u32'
> for 'enum vmbus_channel_message_type' (e.g. char) but it doesn't happen i=
n
> real life, just add a BUILD_BUG_ON() guardian.
>=20
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  drivers/hv/vmbus_drv.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
