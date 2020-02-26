Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48A4C170823
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Feb 2020 19:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgBZS5a (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Feb 2020 13:57:30 -0500
Received: from mail-bn8nam11on2101.outbound.protection.outlook.com ([40.107.236.101]:23904
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727276AbgBZS5a (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Feb 2020 13:57:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egsJm4Ej2n0yQpISDy6xmj54/ngVMYp5lVyACpVBRkWv3FlYKZVrheHS0Y0Uj7pCblKRKN+Na/nJt1wAlXR5jxUlW7VFzIATrf8icR0PiXKNjQc6LqxP041ExQ2eANcsPJnh1FIxXM2w9gaZnr54G+PWGU+Gi5WuazGuzRp/itkHQn/ZtAJy+AepSy+fiqTgkPO8h1G7hT1XiB39TR3q8PPkgNxNyUP0J/c7J7LxrF2ooVgfM+eoC0ktp1dmGJGeI6KXiZDrL1XpUa2LL8sgBZmcYdHRlmW1rxYd7e+ysMub5cC4vvcW1NQN27zF2KQpK1FuiGxOpolBSfZjn0UAPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWF5Mu9gFyPFNGiWokB/U7riIeypH+kSPeWmV7eib/E=;
 b=jzMc5QTdNBM3NUJg2tWby3zWLIg7n72ZDSA8Ipe1TNwzTWFDC9ek1KkkTw0MdiB5QFZDbI5WX+mkJxb3ajTXN6TK2YrzW/ubaT17WoGUdMUQA9kUuNH3bmzfj54QHfMQVIOpNTn60VjhnGw/aVcXBNLDBeA+a1zNhWxg42/NPARt3wdkOK8Sz7yFw9C9W3R9gQBbkY8OzuCl2xnKg6BGIUTUAhMKm5JxGQC+sJz3rs5pXUpjs8RposroI6cBYD6IWKt5/aZ+SXEzhWHVAos4WMSlPxSQyqqENUIW+Ldn990pnS1PtzwSf96yS8mkSQ4a2oWbUQfiYliJ2KiXUjQvEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWF5Mu9gFyPFNGiWokB/U7riIeypH+kSPeWmV7eib/E=;
 b=JhMpeXX+cpj94wTaOiWpz262MqgORK74si5ncSPa2xYJXEStRMAp1KRCO45qr0KEcjwRj9C96t1VJncg/SKavd9WO5zu6PBGhzQG4xu7HLZBEAW/BPu6apiuK2VPIXCgFR2CLubEel31rbFodHdYdhZYQiFVGKUMBL6CSGMHHTs=
Received: from MN2PR21MB1437.namprd21.prod.outlook.com (2603:10b6:208:208::10)
 by MN2PR21MB1263.namprd21.prod.outlook.com (2603:10b6:208:3c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.4; Wed, 26 Feb
 2020 18:57:24 +0000
Received: from MN2PR21MB1437.namprd21.prod.outlook.com
 ([fe80::88fc:b79:c64d:595f]) by MN2PR21MB1437.namprd21.prod.outlook.com
 ([fe80::88fc:b79:c64d:595f%4]) with mapi id 15.20.2793.003; Wed, 26 Feb 2020
 18:57:24 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] Hyper-V: add myself as a maintainer
Thread-Topic: [PATCH] Hyper-V: add myself as a maintainer
Thread-Index: AQHV7M65Dqnpg8/u4k+/19dW8lAv0Kgt0a6A
Date:   Wed, 26 Feb 2020 18:57:24 +0000
Message-ID: <MN2PR21MB1437C4BAAA6E38200C92F5DDCAEA0@MN2PR21MB1437.namprd21.prod.outlook.com>
References: <20200226180102.16976-1-wei.liu@kernel.org>
In-Reply-To: <20200226180102.16976-1-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-02-26T18:57:23.1015810Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ca0a922a-df54-4510-95e2-0cd43ed91678;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cc21d4be-02cf-4733-b338-08d7baedb7b8
x-ms-traffictypediagnostic: MN2PR21MB1263:|MN2PR21MB1263:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR21MB1263838B4AD2E697C5C621DFCAEA0@MN2PR21MB1263.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(199004)(189003)(9686003)(55016002)(10290500003)(54906003)(8990500004)(110136005)(107886003)(4326008)(71200400001)(8936002)(498600001)(81166006)(5660300002)(81156014)(66446008)(66556008)(66946007)(64756008)(66616009)(66476007)(2906002)(52536014)(76116006)(86362001)(33656002)(26005)(53546011)(7696005)(186003)(6506007)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR21MB1263;H:MN2PR21MB1437.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vIWCr4aQH9IL1WT4MoO9lxZCQdTAnRnLPvx7I/VsrOQse2ssdAiM/Lj/dYuhu6QkR9H3Fs4hUUOeTiWjoB9x7tAceStnOl1C4VMrorpLVec4s+mnWectFinKyIxQ9R+UBkZquxvJ9UjFqlBsMT7ym0SuJuAg3z8sBarBxlBFiWFDgK2s6rQXj8owWdjsieWbIbgxJsRmM1Ao7DjWuat4ccjA8FINFbw9k0oBflJOGMUVUEkOGkfO7BJuCxeMN6PTjVHYmEbLO84ThMVNJ5oLHRSU5D/AT1bDmaGmHIxcCl6UapOnloKqIff956JRjd5dg0JC0w0C5/OHKdWlVDAn8sh0FC6divD8z8YFcTddXOb5zCuodqCpCZUhnv7++R5pHs6mAYvhJI9R6OxT69zMZ4j6Fhg2GxTAFIjFIdZOH5yRXZm0HeLbSJ8U0l51mFUf
x-ms-exchange-antispam-messagedata: sHwEDhVFqNWwVUilEa/Vq5sPfqy2NgFUNIHuaJmYHragK7NzOU2zhJrePicCAnT0go+bN3b6AW12qYKRl8r6MuzCiOQoLD2SZfYAL6DPbxIDggJ2zVYxsubhVg2+rzQGyNjC8GAAQtk2RoEAfMgUKg==
Content-Type: multipart/mixed;
        boundary="_002_MN2PR21MB1437C4BAAA6E38200C92F5DDCAEA0MN2PR21MB1437namp_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc21d4be-02cf-4733-b338-08d7baedb7b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 18:57:24.7011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ATDHljUsaDygMpBm/MjEvXSDKBSeS703hLNCsaLtfqpa4PCCJL3DFQeYp/0SrwlnvEbOrWKo1HLam0oF/y7W2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1263
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

--_002_MN2PR21MB1437C4BAAA6E38200C92F5DDCAEA0MN2PR21MB1437namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Wei Liu <wei.liu@kernel.org>
> Sent: Wednesday, February 26, 2020 1:01 PM
> To: linux-hyperv@vger.kernel.org
> Cc: Wei Liu <wei.liu@kernel.org>; linux-kernel@vger.kernel.org; KY Sriniv=
asan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen
> Hemminger <sthemmin@microsoft.com>; Michael Kelley
> <mikelley@microsoft.com>
> Subject: [PATCH] Hyper-V: add myself as a maintainer
>=20
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> Cc: linux-kernel@vger.kernel.org
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Michael Kelley <mikelley@microsoft.com>
>=20
> Sasha's entry hasn't been dropped from the Hyper-V tree yet, but that's e=
asy to
> resolve.
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8f27f40d22bb..ed943f205215 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7739,6 +7739,7 @@ M:	"K. Y. Srinivasan" <kys@microsoft.com>
>  M:	Haiyang Zhang <haiyangz@microsoft.com>
>  M:	Stephen Hemminger <sthemmin@microsoft.com>
>  M:	Sasha Levin <sashal@kernel.org>
> +M:	Wei Liu <wei.liu@kernel.org>

Thanks for being a new maintainer for Hyper-V!
Sasha submitted a patch (attached) on 2/05 to remove himself from the=20
Hyper-V maintainer list. But his patch wasn't applied yet.

You may either re-submit his patch together with yours. Or just replace=20
his name / email with yours in one patch.

Thanks,
- Haiyang

--_002_MN2PR21MB1437C4BAAA6E38200C92F5DDCAEA0MN2PR21MB1437namp_
Content-Type: message/rfc822
Content-Disposition: attachment;
	creation-date="Wed, 26 Feb 2020 18:57:24 GMT";
	modification-date="Wed, 26 Feb 2020 18:57:24 GMT"

Received: from BN6PR21MB0849.namprd21.prod.outlook.com (2603:10b6:208:10c::27)
 by MN2PR21MB1437.namprd21.prod.outlook.com with HTTPS via
 MN2PR01CA0014.PROD.EXCHANGELABS.COM; Wed, 5 Feb 2020 21:32:56 +0000
Received: from BL0PR03CA0002.namprd03.prod.outlook.com (2603:10b6:208:2d::15)
 by BN6PR21MB0849.namprd21.prod.outlook.com (2603:10b6:404:9e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.4; Wed, 5 Feb
 2020 21:32:55 +0000
Received: from BL2NAM06FT010.Eop-nam06.prod.protection.outlook.com
 (2603:10b6:208:2d:cafe::97) by BL0PR03CA0002.outlook.office365.com
 (2603:10b6:208:2d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Wed, 5 Feb 2020 21:32:55 +0000
Received: from mail.kernel.org (198.145.29.99) by
 BL2NAM06FT010.mail.protection.outlook.com (10.152.106.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2748.0 via Frontend Transport; Wed, 5 Feb 2020 21:32:54 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 1BFF82072B;
	Wed,  5 Feb 2020 21:32:53 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC: Stephen Hemminger <sthemmin@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Michael Kelley
	<mikelley@microsoft.com>, James Morris <James.Morris@microsoft.com>, Sasha
 Levin <sashal@kernel.org>
Subject: [PATCH] Hyper-V: Drop Sasha Levin from the Hyper-V maintainers
Thread-Topic: [PATCH] Hyper-V: Drop Sasha Levin from the Hyper-V maintainers
Thread-Index: AQHV3GvU6ujUZzY+GkS/lGxXQt6mOw==
Date: Wed, 5 Feb 2020 21:32:42 +0000
Message-ID: <20200205213242.31343-1-sashal@kernel.org>
Content-Language: en-US
X-MS-Exchange-Organization-AuthSource:
 BL2NAM06FT010.Eop-nam06.prod.protection.outlook.com
X-MS-Has-Attach:
X-MS-Exchange-Organization-Network-Message-Id:
 f1917b37-f4a3-4bbb-ec19-08d7aa82f656
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
x-forefront-antispam-report:
 CIP:198.145.29.99;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(4636009)(189003)(199004)(1076003)(2160300002)(36756003)(4744005)(45080400002)(6666004)(86362001)(356004)(8676002)(1096003)(6966003)(246002)(450100002)(6266002)(7636002)(7596002)(26005)(956004)(426003)(336012)(5660300002)(34756004)(2616005)(34206002)(107886003)(4326008);DIR:INB;SFP:;SCL:1;SRVR:BN6PR21MB0849;H:mail.kernel.org;FPR:;SPF:Pass;LANG:en;PTR:mail.kernel.org;MX:1;A:1;
received-spf: Pass (protection.outlook.com: domain of kernel.org designates
 198.145.29.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.145.29.99; helo=mail.kernel.org;
dkim-signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;	s=default;
 t=1580938373;	bh=5pX9Wz45X6jX7QtLlhhgzmhVrZWZIX3BDnNmDXbWHek=;
	h=From:To:Cc:Subject:Date:From;
	b=yCV/cVbXj3QOXFUrwJcZGmv2Ee5JhlnZW21u/58P6MfbGKGzojrC7Ip+3UHHJzpLj
	 Ejr1UY48Zc8/5aiZ5fVGoE5gQMRsPCs2M0UEQxce0hweT3ogE9zPaMxcPIhpL0mfqf
	 EjBur5RSDuY3WxgjRKp+Kd1iE+fLR/9Jyd9mX2Lo=
x-ms-exchange-organization-originalserveripaddress: 10.152.106.121
x-ms-exchange-organization-originalclientipaddress: 198.145.29.99
x-ms-publictraffictype: Email
X-Microsoft-Antispam-Mailbox-Delivery:
 ucf:0;jmr:0;ex:0;auth:0;dest:I;ENG:(20160514016)(750127)(520002050)(944506383)(944626516);
X-Microsoft-Antispam-Message-Info:
 =?iso-8859-1?Q?rjWp9zVze0sgEPiSMQXcrobkVn1uvgUAREA3yj/qEJprHkshQXKfFG+LMM?=
 =?iso-8859-1?Q?qAgaMrp/NJHXT6/Cu+W8gVv09lYBYFIHXC896xRs0Gww08V+vPIC3mUMAt?=
 =?iso-8859-1?Q?7ldde/PDPH60Iv18BRi2F7BTg9PbYFLr97Vf7OK9XclkHKqbCm0cFlDAGL?=
 =?iso-8859-1?Q?JreM3u8aFJSn5YzlLEuyfN8362zS99fVmnIp4rqW8GxpuTakLHXPlXLx5v?=
 =?iso-8859-1?Q?/qNqRjIN8RpPm7iTMPbED8IO8bydOV/xKsa/L4LiiJPyhuo8RRyJso1VbL?=
 =?iso-8859-1?Q?w7dc5H0vQVcN7D9N5JqeH6/UqdxvzlUJsnNPar2vJLAdB8I8lELSwDND4+?=
 =?iso-8859-1?Q?RMkXqt4ZeKdIC8I4yBAJutd2+cXXGZdjO92xeR1py6lBsk8AdjPzq5Djls?=
 =?iso-8859-1?Q?EAIYccp369uXfSXHHde2KmmkqNr2/4z6f+lDcGEwgWDWeqJH7BjL6OQA02?=
 =?iso-8859-1?Q?ofE65WV4IiLdSeZJjvfiqilSjC2jNLyWunUINwn3S4V0OuZ9wh1GGREv9O?=
 =?iso-8859-1?Q?w+ZGOyNvaWCSgzYVrvy8e098ML08am8/r2YviSLfr0DbAZV/hJrHJNCAsF?=
 =?iso-8859-1?Q?dfphEzXbaGAKjj9zp1aWF4SrHIOWXUSmipDo9XZEMJiJFwlf22n1xh1gqO?=
 =?iso-8859-1?Q?WE0vb0WNLHr/9J41xjF25QLwWDxkhTmm06qBdCYH7OAU2TNf7sAvEnsnZX?=
 =?iso-8859-1?Q?ei8PvpBIOtL4BU5a5ORLVdztdnwOUyrmo8Z0cIIRTGRoQ0kPTuT6HpgkV7?=
 =?iso-8859-1?Q?LM5hRmeaVjfBTSwqrKjvHvGW8iIbBX1r7eTMqCvxIpyUMmAWPANNQYmMNQ?=
 =?iso-8859-1?Q?3iKzKfmSiko7z+nl38Vi3HnfVX7aA7cOzEv0A7m0Ai9VMJltmPvPYBt1Uj?=
 =?iso-8859-1?Q?d7P/9QYuopuX/k4gN5eoA3WH9xRcFH5xQCo+/+3tOtr/hv8T5B2kh1bFQm?=
 =?iso-8859-1?Q?K8ycDFmQWTeJRhFaekyq54HIwcOnaLu5EJVMnCt+vpxBsiiXNLO6zhFZNZ?=
 =?iso-8859-1?Q?h1HzkmfdWy6uEvtsZeG14m1MGfKwU+LezvgYEq8/5XtovZxc1EfN7te+fH?=
 =?iso-8859-1?Q?dtPCpj4WoVbfMotFZKPSO+08AVHOprNW0Umbo+fvvHZ5VkC1gpf6YpoTLw?=
 =?iso-8859-1?Q?qwqsGcIQ4LDYmGwh/eF3j1gVd9lnKUJZ5REfN7V3YP6JyIHnaQOsRem8fB?=
 =?iso-8859-1?Q?kAMq5wcOjHcOGtxH96iDqkEVtdAIIJiJRTsJyxlbQV0xNJq7WltmJaXQ1e?=
 =?iso-8859-1?Q?61itoK3yWlo4pebMFfSb0LCw31Yy/2Qd00WJpVLiDnIoK78RVOqOpp4UgT?=
 =?iso-8859-1?Q?Q8nHLaKaKy38FWOX0P4lSqCK2U5WKUIOPuU1vmqPP3Ko8BpN3UCYde8CsI?=
 =?iso-8859-1?Q?iYGRJ2eFAOEekrrOqoe0S4PGTtzFRdEQiGKUL/qLQvqpUI9O8YEhk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ed8bb8a1f5f..92cd55dfabe5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7732,7 +7732,6 @@ Hyper-V CORE AND DRIVERS
 M:     "K. Y. Srinivasan" <kys@microsoft.com>
 M:     Haiyang Zhang <haiyangz@microsoft.com>
 M:     Stephen Hemminger <sthemmin@microsoft.com>
-M:     Sasha Levin <sashal@kernel.org>
 T:     git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
 L:     linux-hyperv@vger.kernel.org
 S:     Supported
--
2.20.1


--_002_MN2PR21MB1437C4BAAA6E38200C92F5DDCAEA0MN2PR21MB1437namp_--
