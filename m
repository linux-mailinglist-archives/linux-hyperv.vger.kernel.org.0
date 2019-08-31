Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1E6AA419B
	for <lists+linux-hyperv@lfdr.de>; Sat, 31 Aug 2019 04:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfHaCBq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 30 Aug 2019 22:01:46 -0400
Received: from mail-eopbgr1300098.outbound.protection.outlook.com ([40.107.130.98]:21280
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728246AbfHaCBp (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 30 Aug 2019 22:01:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liNga97ZcJlWJhjRw44csq+CIF1vtthct6jXJSToCm5IVWJMqCD6HM6gZCqZBNS0KWR0kHFgbeveQCmT6FMhmqBSNIZdlRma2HKetlczr7ow4a1xsmdfNj20i7RpdwDFHUP+lZL5eBIwRCAusKl4dFX+Cp8HEc2xlGWiunuhK5mWJAbQh9Nq+wDkfKFDdFI1Dn9Fq2L22bQShFwW+60rBnVR9YYGuAL1ZQt6//ZhwCqyEgqxFW86AN/bKSiQs9FVUfvW4ORt2SVac4U8sTfgoFZTTfqXqzFdMy/HubpZ4WGc60LROU0ZVKMp4oaDmbESdlil384n8KDmV+tpajg25w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTOeg8ivEO8FprdJugCquGVdA8LgdolKrd9VxjbhI0o=;
 b=iOSkcwPNY8hyHlfEcZOyxBZQkJW4IqsandMluRjIPI02Zujt5ETHZFg3SfCucS1/+QzybfJY0Oouz6dG/xNq3qfVqYEEzucobhuswlgwx9KuyM62JzQfmwc9IEXFTTwVWdesyJQaTWxaLq/JijYB9kosA1C+k99pqI35QoFfubN3fcpYlci86/qw+vb73bL3P8Kh4Sa0DZVK2M/W82F6wHhFo46sFyWcZXTeoJVJiVqnhzl8h+TPonldifIFROXAgSmCX28OKGAR1xgnSb0rpSfTEV+zjwMVJTK/6zLRkOhW12yCzq+pKCntKpRCWhO2zXqWgU9/HqFWbUX1EsR5+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTOeg8ivEO8FprdJugCquGVdA8LgdolKrd9VxjbhI0o=;
 b=JvpkIul1I4TklH1b6ooB7oj4ViNZ7b5/xS2/17K2MdiM0DU3SaOxjVS4Uy2i5EbtMybi0XtBMUbFftFx4uQOHUqqXohFnMmh5H/N9qvkaIfMsnL3YyRckrPzqsBU5ekmZqEOstMxnz/qABX5v7519WNLrTGckmLUjHcyEN+In8c=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0170.APCP153.PROD.OUTLOOK.COM (10.170.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.2; Sat, 31 Aug 2019 02:00:56 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3%4]) with mapi id 15.20.2241.006; Sat, 31 Aug 2019
 02:00:56 +0000
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
Subject: RE: [PATCH v3 10/12] Drivers: hv: vmbus: Clean up hv_sock channels by
 force upon suspend
Thread-Topic: [PATCH v3 10/12] Drivers: hv: vmbus: Clean up hv_sock channels
 by force upon suspend
Thread-Index: AQHVVvngIm13qifSzE6BddexMOZgK6cJK+3ggAtlaXA=
Date:   Sat, 31 Aug 2019 02:00:56 +0000
Message-ID: <PU1P153MB0169EC39BD51EFF1FD3BB73CBFBC0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1566265863-21252-1-git-send-email-decui@microsoft.com>
 <1566265863-21252-11-git-send-email-decui@microsoft.com>
 <DM5PR21MB013722B88011C7D587BB6182D7A40@DM5PR21MB0137.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR21MB013722B88011C7D587BB6182D7A40@DM5PR21MB0137.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-23T20:02:10.5815340Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9569c2bc-1aff-407a-a5da-655ff005400a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:5cbd:8ecd:62e5:20b7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09b10d9e-c98c-4a85-4d3f-08d72db70fe0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0170;
x-ms-traffictypediagnostic: PU1P153MB0170:|PU1P153MB0170:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB01709D30853FFA80FC1B9777BFBC0@PU1P153MB0170.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 014617085B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(189003)(199004)(76116006)(110136005)(2501003)(74316002)(8936002)(25786009)(4326008)(102836004)(478600001)(6246003)(229853002)(186003)(6116002)(8990500004)(53936002)(76176011)(71190400001)(71200400001)(1511001)(6506007)(55016002)(7696005)(9686003)(6436002)(14454004)(446003)(66946007)(10290500003)(66446008)(64756008)(66476007)(66556008)(86362001)(10090500001)(81156014)(14444005)(256004)(305945005)(81166006)(2906002)(22452003)(316002)(33656002)(99286004)(11346002)(476003)(486006)(2201001)(8676002)(46003)(52536014)(5660300002)(15650500001)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0170;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lYKW8WemgNGZNO3OofiwvL6eCblTs81akiy/wmlC1aE9a/QpHKsUmBjZNWJAL8ynbsRhy/atTEkJDIEUw56Elg9SaKwkiMdTLFFyvd/dVtCn3pPQnZ8IuCK+M17elAHa6BDaTUB1vf7EbBswimqFMFT2PWTGFZEYmaVN4fvXDQoJVWthKhuoDcYrK3IYu04Z5AId/uWuJ9Ss00/S4p+PgrTXJ1BltbWOT6CrnofSZeFL6n3v1UZQs3LkWAOew2iGVcB1PKgSzobLIkwi4eUNdZkKOAbw0wxG1f1Bh78naInM3pPm4OV6X28UwaHkkWKbvXR2/rntSNCq4sB3UcmCmBTnCyBnNLYKooU4Y8DJp8po66VtIb0j+IDvwTKp7skkA5htejt0E4WiOLFetrRVjDxJ1zHo+Ja/k8FuwPgyzck=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b10d9e-c98c-4a85-4d3f-08d72db70fe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2019 02:00:56.1049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YcHP+UsPBYXNnI9M3l1OQk3pskd3xpj+ZVogPTbAItNSXbgeqJDJ4GfMUOMQ6nZNkXtJSUDHRcdS5SHNR7JH1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0170
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Friday, August 23, 2019 1:02 PM
>=20
> From: Dexuan Cui Sent: Monday, August 19, 2019 6:52 PM
> >
> > Fake RESCIND_CHANNEL messages to clean up hv_sock channels by force for
> > hibernation. There is no better method to clean up the channels since
> > some of the channels may still be referenced by the userspace apps when
> > hiberantin is triggered: in this case, the "rescind" fields of the
>=20
> s/hiberantin/hibernation/

Thanks! Will fix this in v4.

> > @@ -2091,6 +2127,25 @@ static int vmbus_acpi_add(struct acpi_device
> *device)
> >
> >  static int vmbus_bus_suspend(struct device *dev)
> >  {
> > +	struct vmbus_channel *channel;
> > +
> > +	while (atomic_read(&vmbus_connection.offer_in_progress) !=3D 0) {
> > +		/*
> > +		 * We wait here until any channel offer is currently
> > +		 * being processed.
> > +		 */
>=20
> The wording of the comment is a bit off.  Maybe
>=20
> 		/*
> 		 * We wait here until the completion of any channel
> 		 * offers that are currently in progress.
> 		 */

Will use the better version this in v4.=20

Thanks,
-- Dexuan
