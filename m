Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2356826810E
	for <lists+linux-hyperv@lfdr.de>; Sun, 13 Sep 2020 21:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgIMT4k (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 13 Sep 2020 15:56:40 -0400
Received: from mail-eopbgr1320127.outbound.protection.outlook.com ([40.107.132.127]:10461
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725938AbgIMT4i (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 13 Sep 2020 15:56:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikuTMMycYC+i/10TXTw3xcifLfE738VKZQHl/oWn6TJ//i9k47QnXL3GdTJkW87rfJeiUAICNqTSF59aCcQ6HoJ66f6V34cAJ8woVU0H0bBrCmjRrMF05dMBxBszovNh0hBkb/LC5UrDCg/rtyYZFjK4ap06L9EGxQyp9OWRaMxLzo+PFzLtG93Qg9/dXkKIMl1lhNuM4FVq03pJGN8KLwYdc9XI95077JSAe1DLmeViqur74nKtVrT4dbZPvm89fj+STw1oQwfe3A7o1yQpVWtyM53A3jCislPKkWk3k5E9t87B2uOgetGJYybkyGmZhB4D+WPhYye2+vPjINiy+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hT3cNtoMSaA+a0x7sYn8j9uPsFw+RUyJaTCLOSS78A=;
 b=H6qdHT+Is3/t6yUwVywQRdem8to2ldKv5+twsi/NWY0cDb5rui6szbELTorH9/9WEOCIe5pTYDirjJJXkyn+xbgyI4Jg3MmKWoEJJHVaAnMmKGeaWIXyXBdJtelQonndmglaOrBBvk5McNyp1ew6J3AM7N1PqQUucIXKtSNAnH6MpQwG2o61EnkI46VTsJWf3vzXr3WeEr1vrDVfpMUAKJ910b3xAYdKemVKTvlcdohpf/+0DLxAqDCGA/96/gEffPgURUxZjxpDTwCcjMLwgX6kqcdr4ydhqYywiHcQ6tzMGhFniJhcSnxEQloZbpsLmdwKz1ufaCHk3OBWFKUx9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hT3cNtoMSaA+a0x7sYn8j9uPsFw+RUyJaTCLOSS78A=;
 b=FucbGm7a58zi1IJPVlOtB5rE3cgsCbKbbHbIbOAU+3wFr23OZXLAe69SAm/2CJ8yJVPHn6xzpfYF8MSjNYJznb7TkeZcJpF2TaHxYZX1DSXBaBR0M/n5O4J/RU7yvB42m/qdiOxYwy/GOUcQ0LxfvTI871WT4LxlP0m9KaxyKH4=
Received: from KU1P153MB0120.APCP153.PROD.OUTLOOK.COM (2603:1096:802:1a::17)
 by KL1P15301MB0053.APCP153.PROD.OUTLOOK.COM (2603:1096:802:10::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.0; Sun, 13 Sep
 2020 19:56:30 +0000
Received: from KU1P153MB0120.APCP153.PROD.OUTLOOK.COM
 ([fe80::800c:633d:2d74:4f61]) by KU1P153MB0120.APCP153.PROD.OUTLOOK.COM
 ([fe80::800c:633d:2d74:4f61%5]) with mapi id 15.20.3412.001; Sun, 13 Sep 2020
 19:56:30 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH 1/1] Drivers: hv: vmbus: Add timeout to
 vmbus_wait_for_unload
Thread-Topic: [PATCH 1/1] Drivers: hv: vmbus: Add timeout to
 vmbus_wait_for_unload
Thread-Index: AQHWigbafeXbzda8AEi7ju7K5u/Gl6lm+60w
Date:   Sun, 13 Sep 2020 19:56:30 +0000
Message-ID: <KU1P153MB01202778DC760ED16AD687F4BF220@KU1P153MB0120.APCP153.PROD.OUTLOOK.COM>
References: <1600026449-23651-1-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1600026449-23651-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e896d210-3f59-40ea-bb99-231ff09e6f47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-09-13T19:55:44Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:e9e5:cee6:6dbb:2664]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4dab3e36-9745-46d3-aca2-08d8581f1bec
x-ms-traffictypediagnostic: KL1P15301MB0053:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <KL1P15301MB0053B2388FD748459240D3B7BF220@KL1P15301MB0053.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g5Gru7nf0CTUypJrahvlKfst029og6CXozaeaFWSdyJAs/CqIqftY6fPwR3D8uG9pIoD6ZRD+s8W7SpSVvXd1O50szoNnHx7IOGqunJ66zu2l874pJBUuttKdGAnVX65qbVCSXAcGMb3NOu9QXDEY6gecOQH5tTjho4/vAU0rHvXwqo7p/afMx9+mNEacPV6WT6g2dYARr5KUtIIGlHfriveYOSzBQfLFCzEr75uZITOqJH2tb5KeJDPXzfq3PbgTwMR41+SgCHG0T14t/G2qPv1bR4MheIcA7S+788sLL+8vbi9fOwx2eZ4D9dUOqNmxH1T0oPN0pAFb/oMlzG0rjezYjn15gUmEtNuQa+d1MErSOGpsfwhY+WxxINmC3Oe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KU1P153MB0120.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(8990500004)(8676002)(71200400001)(55016002)(8936002)(478600001)(2906002)(316002)(7696005)(33656002)(4744005)(83380400001)(86362001)(76116006)(10290500003)(4326008)(9686003)(5660300002)(82950400001)(82960400001)(66556008)(66476007)(64756008)(66446008)(186003)(6506007)(110136005)(52536014)(107886003)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: dCz9fslyrhb3mN49fm14RUaa6I8sVl93twre8hYp3Fbp1S+v5iAUO7df/W5BZ+FhMUzQs1/c93sg8tsZmCsce+NGpfPu9GPoTAJVDxGazUAc3+K9ytojOP9DPfui8JTzFrFSPzyHwGTFSCxJYM1YKMNBlFzfju46WqwGwHt+zZTHT/04FHVwzXXRccr7krkgZpH1Vo/hinwfqwGOQ7MAYe4UD/99SLsgGV5Fbbx5iEsPeaomfrTsgi6UxgBNjolIF90I3pLuOB7y+sdOqkIYKRJNvhdg9dMdybB0/E0PpxFQhQVg8QoNqtElaqzVS0B9laK0F15PsAXEPW1MZDuW+pR9VVqICynWpJ0eC+UH9A7MshWzJYwvnzoGPxbd/kgFVoVV3SLyAxvbAj9qpIBHvXGmrCbAp3WKeog4bYNVys/5wNKu1YEBW4/gx7BRwyUcpHTk6IKlelFGlgzXuu4ymNwzzhRvJhI9RnsfCcYFVdoJ5+/vTy+S6SY60qprNN9Qo+mw7ddMzActQn12peqNMZieFPdKM9a3JYDAyOOWI8+Xv+iQ2c3tBpwTJMmr1ukW+xM5JAhfxpG74WPYQZOztAhPsUrmfAJGu4GalnPVf6oNzTg6xxhrWju8qmbHWalEi0jaN8zx8uYMz4DrfB2mVT9vaQ4S9nJvr6qbwe+Cc37iRquOm9ni1tV6l/hLwS6nFnpfIJFxe7j8LnRQ7tQiaA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KU1P153MB0120.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dab3e36-9745-46d3-aca2-08d8581f1bec
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2020 19:56:30.1894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kOnxblGaYA2Ls4FKDEk49oLGV3Sk+Bn4ep7w43IlVOQbvcg8ZUpqSO760zv/3NC67FznJg7jf+vcVzNWUd6npg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0053
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: linux-hyperv-owner@vger.kernel.org
> <linux-hyperv-owner@vger.kernel.org> On Behalf Of Michael Kelley
> Sent: Sunday, September 13, 2020 12:47 PM
>=20
> vmbus_wait_for_unload() looks for a CHANNELMSG_UNLOAD_RESPONSE
> message
> coming from Hyper-V.  But if the message isn't found for some reason,
> the panic path gets hung forever.  Add a timeout of 10 seconds to prevent
> this.
>=20
> Fixes: 415719160de3 ("Drivers: hv: vmbus: avoid scheduling in interrupt
> context in vmbus_initiate_unload()")
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Reviewed-by: Dexuan Cui <decui@microsoft.com>
