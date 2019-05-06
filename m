Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D68EB150C8
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 May 2019 17:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfEFP6r (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 May 2019 11:58:47 -0400
Received: from mail-eopbgr1310117.outbound.protection.outlook.com ([40.107.131.117]:53664
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726413AbfEFP6r (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 May 2019 11:58:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=g79QLBHbiATiwiPBWCx60OeiFcilG3pmT8G0/DYMwf3UKJaHsgWPH06gmQI8FhGAZnBc6EdLqMUAE0wOBz81Wtl4AoFGLQt7DTd9htJuAI8iGhVE3Z17yzm1IRfx4OZu2ZX2kUui6AByMr68eIwVzFo/9OUmkvIqLd7IxII8cxs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNXz04Z7C+5W3TJtwrxrwqE607ze5QMOc5LQK7Sww2I=;
 b=ODHu3he2kEnXX3CPuyrlQqTa4Tkl+HRh3Nk7aL+KhF0Hvn6iidw7hrAgXEILqOSsvsQ4zjBkuKONj74/Lj69/kEyKibSX6uTVymo/FzUnzl7O/FyAcCwi29qzdjZ3c1krOENDNX19Q2iFi3YixpvZibwbjTmq7wt1hwoYhHTLfc=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNXz04Z7C+5W3TJtwrxrwqE607ze5QMOc5LQK7Sww2I=;
 b=IcUTrE7YrjrQyh3YcUxp6lkXuweu8Bbu1PHa2MwX98NIy1BTLKu1/clUSFUXL23sFqh71t/VXJK1lV6kvMeQFPIUZCXGYlOXAh/qJr/IEgsy2A1RmHFVxnr0HpH1+8iQJzy2/qU6ymMfJGYUhwqe0VPv1z52cW7qHoNYQMBUbqM=
Received: from KU1P153MB0166.APCP153.PROD.OUTLOOK.COM (10.170.173.13) by
 KU1P153MB0165.APCP153.PROD.OUTLOOK.COM (10.170.173.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.4; Mon, 6 May 2019 15:58:39 +0000
Received: from KU1P153MB0166.APCP153.PROD.OUTLOOK.COM
 ([fe80::6c7b:a3:ef4d:9b]) by KU1P153MB0166.APCP153.PROD.OUTLOOK.COM
 ([fe80::6c7b:a3:ef4d:9b%6]) with mapi id 15.20.1900.002; Mon, 6 May 2019
 15:58:39 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Juliana Rodrigueiro <juliana.rodrigueiro@intra2net.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: Hyperv netvsc - regression for 32-PAE kernel
Thread-Topic: Hyperv netvsc - regression for 32-PAE kernel
Thread-Index: AQHVAeqHjkTZJm8GekSKWOjutArYtKZd8KoAgABTs4A=
Date:   Mon, 6 May 2019 15:58:39 +0000
Message-ID: <KU1P153MB0166488D1E03E925C8F022A4BF300@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
References: <6166175.oDc9uM0lzg@rocinante.m.i2n>
 <DM5PR2101MB091875296619F1518C109E71D7340@DM5PR2101MB0918.namprd21.prod.outlook.com>
 <PU1P153MB01698936BF3332FCBF64D65DBF350@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <5083893.yzDQlZqgr7@rocinante.m.i2n>
In-Reply-To: <5083893.yzDQlZqgr7@rocinante.m.i2n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-05-06T15:58:40.6761077Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bd67efc3-65a5-447f-9d27-d9845490d00f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:1760:9532:78f0:9f27:a980]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 712fc096-9d90-41f0-f173-08d6d23bb4d6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:KU1P153MB0165;
x-ms-traffictypediagnostic: KU1P153MB0165:
x-microsoft-antispam-prvs: <KU1P153MB0165F95CEA0E512BA674C55BBF300@KU1P153MB0165.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(346002)(366004)(396003)(136003)(189003)(199004)(6246003)(4326008)(476003)(11346002)(8676002)(6116002)(86362001)(53936002)(66476007)(10290500003)(52536014)(8936002)(71190400001)(107886003)(66946007)(256004)(73956011)(66446008)(64756008)(71200400001)(66556008)(76116006)(22452003)(8990500004)(81166006)(81156014)(86612001)(486006)(10090500001)(446003)(305945005)(7736002)(478600001)(4744005)(54906003)(5660300002)(46003)(76176011)(316002)(68736007)(7696005)(53546011)(74316002)(33656002)(186003)(25786009)(9686003)(6916009)(14454004)(99286004)(6506007)(2906002)(55016002)(6436002)(102836004)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:KU1P153MB0165;H:KU1P153MB0166.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FXyj++7xoWyUw07TXGj8KC5MGR01fmafRAK0MpCqzN0bNR+lT3wsss2UZyUarfO1MULqiffLmSaa7KyggfL6JJzSRV6w0sDcroU7cdNPgPKxXq+SqhqkfdSLtu0OHZDuWUhO4abw3j+4F3HbnAnj8fuCCzahQpeQdLlDbXfPf3nu2gPySptIeCAIXiCTnkujbZApy8Q0tz/mECTRv5foGVI/HiG1NYRUXgTmRTxX4jZL2L4YcBwKlac0rmX+9OEtKGDXWiFH01fyWsRWcMQjPQ1iXYOicy2s9B/O20TG0et87CNbejfykYjX2GJzJ0sAjq0L2Xiv+kbuuZzJeiF1hhOx/1tqNFSqaiK7OdoboNb8KrhBSnXCEYLuurQbkH5P1jS1HvW8iGz9xXxwyqb4URIjBw/9n38AFRMvsJYbv4E=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 712fc096-9d90-41f0-f173-08d6d23bb4d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 15:58:39.2705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1P153MB0165
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Juliana Rodrigueiro <juliana.rodrigueiro@intra2net.com>
> Sent: Monday, May 6, 2019 3:56 AM
> To: Dexuan Cui <decui@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> Subject: Re: Hyperv netvsc - regression for 32-PAE kernel
>=20
> Hi Dexuan.
>=20
> > Can you please try the below one-line patch?
>=20
> Nice, easy one liner and it works well for me.
>=20
> I hope this patch will be applied.
>=20
> Thank you!
>=20
> Julie R.

Hi Julie,

Thanks for testing the patch!

I'm going to formally send the patch to the list.

Can I add a "Reported-and-tested-by" tag for you?

Thanks,
-- Dexuan
