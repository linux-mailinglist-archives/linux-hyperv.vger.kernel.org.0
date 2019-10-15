Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2B08D7716
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Oct 2019 15:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfJONIy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Oct 2019 09:08:54 -0400
Received: from mail-eopbgr730122.outbound.protection.outlook.com ([40.107.73.122]:33093
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725710AbfJONIx (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Oct 2019 09:08:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjZrtSVe7RKEQK5JkEeLx5qwelIjGAqriHbnElhltxhPt7IzuePadXFeYofZZDO6w2JbE7xJ7mldLzlcE/rT/hp8PqhNGCuZFttMXQQ5v+eF4kM3x5P9zz7ULddXpuRKSZExM0P9xCUYIRcSJIUySyODOT3A/JZ9yeWrzDIYeKvalUOmmo7XpRUZUj4h14HgxVczG+x0aD2I4RLBTlvERD7ClFlscXJwS0fDUoW3oQ2jjw+RvkRea2qdP+9fVMxygx9wd5PeyshzIDXfr1DibcDJFvukznxQnt9pVn1B/WT7NouTZ3uM0iAHNlUreOybd034TtmcmYvyhro7IlKFoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxyrMoYDJ1EFASdBQlhyt2eIckufP6WDlhyA28qUDa8=;
 b=MOtzgpBJLHLtJ6u7uulOAi00iFIn2HgrJVp1MCT/PnKMIBHQ4mZyuP5z7rp7QMCzIAqR4wImJxRg4cmf67XjW9H0qdX7pVu8rQq4UNXTweWjKSb34cFEz3Pbx/BKj0GIaygtHCqepJ4jnqX/qAu5oWer4laF49LbuuwjPtRTBV5iwoKcP6cD3imSadOjhQ2G4lJ1KTqVMqoCfItgMOqaEpHSgEUDrcq4vO5gw9x3xr9jmGxRQtxB7rvFNpjgET37o+z9NRF3KDw2ABeWMMNR77aLGG2bprP98u+n1I2cLonlrrYDUQuyHVTp2+xM0L/aaQ1k4BCa9lTsJaphfakB+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxyrMoYDJ1EFASdBQlhyt2eIckufP6WDlhyA28qUDa8=;
 b=iMSxLUw9hkkwTJhz/tWSAS62zpJ+DaCYdzhw0kgCwX1/Im/hHl5D153n3/NYfINH835E/g7K5exi1Tvjm0JBVPYaAcjJrnxcjtEgc7EcJhmVgV+jjHYJwfk7gR9lCfBMKfD2ML1ULrRrVd8H/cujaiMmMkRLUySNjQdA56QAaiE=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0188.namprd21.prod.outlook.com (10.173.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.4; Tue, 15 Oct 2019 13:08:51 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::a50f:aa3c:c7d6:f05e]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::a50f:aa3c:c7d6:f05e%11]) with mapi id 15.20.2347.023; Tue, 15 Oct
 2019 13:08:51 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Andrea Parri <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        vkuznets <vkuznets@redhat.com>, Dexuan Cui <decui@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: RE: [PATCH v3 1/3] Drivers: hv: vmbus: Introduce table of VMBus
 protocol versions
Thread-Topic: [PATCH v3 1/3] Drivers: hv: vmbus: Introduce table of VMBus
 protocol versions
Thread-Index: AQHVg05M4bwqbVr44ky2rtn0enidW6dbrGQg
Date:   Tue, 15 Oct 2019 13:08:51 +0000
Message-ID: <DM5PR21MB01374065971D72A1817C1DC2D7930@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20191015114646.15354-1-parri.andrea@gmail.com>
 <20191015114646.15354-2-parri.andrea@gmail.com>
In-Reply-To: <20191015114646.15354-2-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-10-15T13:08:49.5073933Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b1bc9aa3-4047-4c87-bb5b-a419d5901317;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72d15ee2-2b28-42b6-36d2-08d75170d311
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DM5PR21MB0188:|DM5PR21MB0188:|DM5PR21MB0188:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR21MB0188FEB4601B48B6D652AE0BD7930@DM5PR21MB0188.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(199004)(189003)(9686003)(14454004)(66446008)(33656002)(2201001)(66476007)(76116006)(66066001)(2906002)(11346002)(7696005)(6246003)(74316002)(99286004)(446003)(186003)(66556008)(66946007)(64756008)(76176011)(14444005)(10090500001)(6436002)(256004)(55016002)(25786009)(71200400001)(26005)(4326008)(8676002)(102836004)(81156014)(81166006)(229853002)(6506007)(5660300002)(4744005)(6116002)(8990500004)(86362001)(71190400001)(8936002)(478600001)(486006)(316002)(22452003)(10290500003)(2501003)(110136005)(54906003)(7736002)(476003)(305945005)(3846002)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0188;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0fhMYGCKuas9k4EMIXidHBdRAp4LxM+a4ncg34PLoBdc3AF8XJ4Pg1TgCDIRyO9awODaieQxDR5RWEaCCcoDFrkuXAFsiSWP6PM98efgr8Kx/HOzWo/AlFVQJUqcYAjXCdbnZsSOzbGqLWMIrCziPsOWzPPF4OhTGhDwf6/NXXXrnLKs3yLzFOXTAfvyxQeJvNncx3IRcIvHJsIEhdm2HkKH8u/CwQgcaV0sYt8odymFUY9qX0Fa8rptxBZLxwnUWqs+XgzmsosUvBgH2bc9xCpEsN4SvcTSr9NbJDHO8uS5rQMeFW251aGGF27teO8T2XevApOMI+pluuyutb9X5KujUf0S2EZcYRHRDvzjaOppfpqJ7jr9zYA+FLER1ZrQvzF4Kuv/45DL3RQp1XAjPpx1/95cls0/BytiqKVfOak=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d15ee2-2b28-42b6-36d2-08d75170d311
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 13:08:51.3773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K/we0K2DcRDht45YO/VzKWani+EqfELLzKeRNBBy5BWp5kdi5IHgtX35ZhUkUqz5TGO3lN53qE7DABr5KEP9sP/mrmdpApLVh85Otm6dXNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0188
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri <parri.andrea@gmail.com> Sent: Tuesday, October 15, 2019=
 4:47 AM
>=20
> The technique used to get the next VMBus version seems increasisly
> clumsy as the number of VMBus versions increases.  Performance is
> not a concern since this is only done once during system boot; it's
> just that we'll end up with more lines of code than is really needed.
>=20
> As an alternative, introduce a table with the version numbers listed
> in order (from the most recent to the oldest).  vmbus_connect() loops
> through the versions listed in the table until it gets an accepted
> connection or gets to the end of the table (invalid version).
>=20
> Suggested-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
>  drivers/hv/connection.c | 50 +++++++++++++++--------------------------
>  drivers/hv/vmbus_drv.c  |  3 +--
>  include/linux/hyperv.h  |  4 ----
>  3 files changed, 19 insertions(+), 38 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
