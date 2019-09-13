Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7621B186D
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Sep 2019 08:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfIMGj3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 13 Sep 2019 02:39:29 -0400
Received: from mail-eopbgr1300100.outbound.protection.outlook.com ([40.107.130.100]:25984
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725775AbfIMGj2 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 13 Sep 2019 02:39:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/dR65aF9I7Ajv/sRAclzENtj32I922wlxLGgazrJC+kwtJOLPDqKY+XUVqkJFQlOJdAYeAcCTGSoZMFCIfUQDTz0RWE624XbabfwuuKhtF1L95SlyjxD7fvwNkTis8yasa0dmmHpt/5de4oMMJZ/05RTLEEAcRGOX1G2mnnFV1EZZrtIOy9EQ0xNEErLs598M7T1HwDOT16TzbeBp6RpLjaWEQcAGNdg1TX3Di2FDvx4o4JWFfqzOYq77MYuNexhB8OrX4ImjHUmnY8XSA6a2dKtjayYB6qVsFEBbzbr39xWm2/TPb1pKPMHhksuqWtWGa3zmeX5wLMpwBmFfFNTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEDn3I0/tnjLu0YIA38BDFhY0r+tPbOoSvEgG/XSfBU=;
 b=OWPjiL2XV9yUGDCpq6cb+8yy3VdQu/1Tc4EpEritrGlxuC73AO9Jfi87MlrY9HISvqJdCl4SdWVS8ZfWMNdYnWtryO/NYT1B5xxTANPO/B2WJRq2LgbznVU3Qt16irUe912kk9IH76MwVz2uQ79EDVNeCQHe9PeH6Qb8dDxGmunK8W1Ml1Bj6MDGH+JHUv3aVOBcAwPdNEjhTrk+3pdQLP0GnuzNfMUCCMj5opph3qzuh/bGhcQ1njDrSB3hXIox009N8KNBRB4sk3vZ1D7jrW7u5rMNkzrdXyjjoLTIb/dO08bsyXkPh2CrBqhlHx5TSu+ZQJkFUNezy0GlUjsS3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEDn3I0/tnjLu0YIA38BDFhY0r+tPbOoSvEgG/XSfBU=;
 b=ispNqzPZXmsdwXr8XJepKaNSHRLmK8cehtMCbNY0KbvyKQhvfF2EutyR2+xx3u21JRbIWiyo2+LOeAuialdy6QqZby5efSf/vqmqcCypJ+JLJr84/C7GJ2pxOApQw3850CfCg7X2UtGmwAJSvMla2l6QeULCQPq9y4Se+8r+VQQ=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0153.APCP153.PROD.OUTLOOK.COM (10.170.188.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.7; Fri, 13 Sep 2019 06:38:42 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3%4]) with mapi id 15.20.2284.007; Fri, 13 Sep 2019
 06:38:42 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
CC:     Iouri Tarassov <iourit@microsoft.com>
Subject: RE: [PATCH v4] video: hyperv: hyperv_fb: Obtain screen resolution
 from Hyper-V host
Thread-Topic: [PATCH v4] video: hyperv: hyperv_fb: Obtain screen resolution
 from Hyper-V host
Thread-Index: AQHVY8n1ZHStyEKyQEWtq6qT8x1cIqcdHi/QgAwV3LA=
Date:   Fri, 13 Sep 2019 06:38:42 +0000
Message-ID: <PU1P153MB0169656B3EC48BFCF4D8C134BFB30@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20190905091120.16761-1-weh@microsoft.com>
 <DM5PR21MB0137D40DF705CDB372497266D7BB0@DM5PR21MB0137.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR21MB0137D40DF705CDB372497266D7BB0@DM5PR21MB0137.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-05T14:05:47.2964572Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5fdc59c0-9d8b-4103-9a31-ed8f82961311;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:49e:db48:e427:c2a0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6550ad53-6303-4ebc-b762-08d738150527
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0153;
x-ms-traffictypediagnostic: PU1P153MB0153:|PU1P153MB0153:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB015333372A4D0BFC44F5EEC8BFB30@PU1P153MB0153.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(189003)(199004)(14454004)(76176011)(2906002)(55016002)(99286004)(4326008)(71190400001)(71200400001)(8676002)(81166006)(81156014)(8936002)(6116002)(478600001)(6636002)(9686003)(229853002)(1511001)(25786009)(6436002)(7696005)(2201001)(10290500003)(66476007)(66446008)(64756008)(4744005)(76116006)(446003)(66946007)(53936002)(110136005)(52536014)(476003)(186003)(8990500004)(6506007)(33656002)(102836004)(2501003)(86362001)(6246003)(22452003)(305945005)(7736002)(316002)(10090500001)(46003)(11346002)(5660300002)(107886003)(74316002)(486006)(256004)(66556008)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0153;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bkWdyIMPEcbEl5/+s2lB2ukS3BC2dZKjHw+l8F8fO0AHMNthzJDOkUAuoCTEUKY5FsBWngEZ+MSZozA/CKZWCmxxitDbYGIAw85li53o6S76X1zetCTblrGfb9LERHPOP9ad+1dHQIYUiTHi5TIS/9+YNTlBdwktsPEH0zHGlVymuwNOwQ+7cEvGtdufXnW/vjsLFkR3YOQ32rZM0U2r+d5LeRqsVAf1nKMwRQQMG+tqeWsxcUOVSJS4VNT7epoU5omNr92SllUo6GTP47KXBtvcH9BCsDTPjWhUF2ht41Ws150k/Bk4u+gwirhuqHh8TYWpAm4U5SIYCpetP2LU+DrofhqaRVNmmSiQ/k4yV7SAM8bpELFF7M1mNfodpM3k8XAWnmfcjtKsaxjBovo9zMZsjtUCspq1aGFP/RA05TU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6550ad53-6303-4ebc-b762-08d738150527
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 06:38:42.3934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ssKiQVeBgMhUvhkoWZf8N1aZ6/T2Y6PQrfjzhuWSApTsAeP6fhjAXwJ7pH7YKhKuwsV8qBvEG7mDv/zBMisa2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0153
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Thursday, September 5, 2019 7:06 AM
>=20
> From: Wei Hu <weh@microsoft.com> Sent: Thursday, September 5, 2019 2:12
> AM
> >
> > Beginning from Windows 10 RS5+, VM screen resolution is obtained from
> host.
> > The "video=3Dhyperv_fb" boot time option is not needed, but still can b=
e
> > used to overwrite what the host specifies. The VM resolution on the hos=
t
> > could be set by executing the powershell "set-vmvideo" command.
> >
> > Signed-off-by: Iouri Tarassov <iourit@microsoft.com>
> > Signed-off-by: Wei Hu <weh@microsoft.com>
> > ---
> >     v2:
> >     - Implemented fallback when version negotiation failed.
> >     - Defined full size for supported_resolution array.
> >
> >     v3:
> >     - Corrected the synthvid major and minor version comparison problem=
.
> >
> >     v4:
> >     - Changed function name to synthvid_ver_ge().
> >
> >  drivers/video/fbdev/hyperv_fb.c | 159
> +++++++++++++++++++++++++++++---
> >  1 file changed, 147 insertions(+), 12 deletions(-)
> >
>=20
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Looks good to me.

Reviewed-by: Dexuan Cui <decui@microsoft.com>
