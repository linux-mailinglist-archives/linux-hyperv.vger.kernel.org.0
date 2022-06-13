Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B507549B87
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jun 2022 20:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245333AbiFMSal (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Jun 2022 14:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245436AbiFMSa1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Jun 2022 14:30:27 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-oln040092064066.outbound.protection.outlook.com [40.92.64.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73DFB41DF
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Jun 2022 07:45:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqwgh3TkRhYe/Mdu7gBXCh4ysE5XHoo+WXUY5HrjFKvPbULBACuKgGHQc4Q9/nz4tkcPx77o+KlbViKrrwZTmyPT0J0AWZN5iSdcY6/0NVZoE9AA0R79ARTc4s3qwv/W1Lg49wseq3Amvc2AsWp/tse7rVzuxFlAb5Z5T/k8rv3re9DxhbAYS+3aC6jPF8RSY/6z3LxfBWRVI+hTmOu57lW+gi0oqEezNkqyWIDAeDoJNArIUfDLWHmu6X008piIslKC6ojkLNsOaDRWiPKsdviLaGmEt/T89GU7X2foL7mGNFK6YhjjKJbOTOa1SOqeFsoHxZVlVrrMAhBlTv5g0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwnHJyEri8OSk69k4/oq8aQhT2Xo8qKV/KphMqL6wb0=;
 b=ApgbK5g/MvI9bwPKF5rfxmmYA2imrE2BBvcARV1SeNrI/7FdlcD4C0QMVf4JtSVZ3QpQ8hL+/9uxjkiBPyJkXSaMSqFu7ym48hWtdnQVgyMm6Ob5zlkHEjDsN4ZlLkaSJhQDu+xR2BmTnXf630YhmFCLNDaSuSnQ/lxHhNj3GPCltexZPwv3EV/9TOYBhvbHCnu26r9b8TIv+tRtCeEivl7Rk3c4VC6Nn2bhiqC9UUkeMOJqdHOjHOHrXG4KMuQVJbu5HjySFtIFseN3q4z+OqX0VZ6XaL9hXMHzc5LHOcblntu0H84ShyMNWi3yz/5Qadu2UMiJ7h++/x1Lqe8H1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwnHJyEri8OSk69k4/oq8aQhT2Xo8qKV/KphMqL6wb0=;
 b=nKn2dmTifHeutreKozo+z/AY40IHua4gPOgTri0kt4WXSp4vZdRQ5IcPO+/1JMgVAwmrXMc0zAAV4diMFHrjCPPppkesDy+j0WTY8B8jcpBCWCEQ126i4pcZd8bvSSfPfjIUtPHH9xLGvL6vDbr4/JOZGM/BVRTpZljq7nP/l6hjPuxu7CQPNh0E7NByRMlnI4bwToIY2t1dhMSEhWrxgsyXFEO4wm5RwwVL4vpjfGAeDbWclArBgN3LnKCAzB03zbYjfhLq20bYyWbBlOxYxFZI5huuyt7VR3aW4o3nNEWT/da/6a8jcOORUC/N+7/S678NZBDnDlYadfmfqldKtg==
Received: from DB3PR0602MB3674.eurprd06.prod.outlook.com (2603:10a6:8:6::17)
 by DB9PR06MB8560.eurprd06.prod.outlook.com (2603:10a6:10:368::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17; Mon, 13 Jun
 2022 14:45:57 +0000
Received: from DB3PR0602MB3674.eurprd06.prod.outlook.com
 ([fe80::69f2:bf3f:5091:da62]) by DB3PR0602MB3674.eurprd06.prod.outlook.com
 ([fe80::69f2:bf3f:5091:da62%7]) with mapi id 15.20.5332.016; Mon, 13 Jun 2022
 14:45:57 +0000
From:   Florian M?ller <max06.net@outlook.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        David Hildenbrand <dhildenb@redhat.com>
Subject: AW: hv_balloon: Only works in ubuntu
Thread-Topic: hv_balloon: Only works in ubuntu
Thread-Index: AQHYfamAAWvh3ZSqEEGxb5JpUeTQGq1Kc/WAgAAHN5CAABp5wIAAAvTQgAHnZtCAAHuLgIAAC5sQgABYZfCAAAKrwA==
Date:   Mon, 13 Jun 2022 14:45:56 +0000
Message-ID: <DB3PR0602MB36748AD171E0F1501C7D1898FFAB9@DB3PR0602MB3674.eurprd06.prod.outlook.com>
References: <DB3PR0602MB3674BB09316BB82B4116F27DFFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
 <PH0PR21MB302513B8500C25CEADA56718D7A99@PH0PR21MB3025.namprd21.prod.outlook.com>
 <DB3PR0602MB3674E1BD958D00FC4B9124ADFFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
 <PH0PR21MB30252F8660A16DE36206B0EBD7A99@PH0PR21MB3025.namprd21.prod.outlook.com>
 <DB3PR0602MB36740EE00B8BA3B897BCB7C0FFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
 <BY3PR21MB3033FBB3CF2011B1D0DA2978D7AB9@BY3PR21MB3033.namprd21.prod.outlook.com>
 <87r13tj8ou.fsf@redhat.com>
 <DB3PR0602MB3674C185377647FDBBEEDDDCFFAB9@DB3PR0602MB3674.eurprd06.prod.outlook.com>
 <PH0PR21MB302540EAB2DF0A368AF4BC57D7AB9@PH0PR21MB3025.namprd21.prod.outlook.com>
In-Reply-To: <PH0PR21MB302540EAB2DF0A368AF4BC57D7AB9@PH0PR21MB3025.namprd21.prod.outlook.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d8924997-2e35-416d-8590-e2f0c0c9a36d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-13T13:56:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [WuqX9J2HTnd4lm0AkA9QJY+UbXS5KG8oaw+ytHE2sK6yk41bzLRl/4oHkrGlm3rE]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b03c5eb1-822d-4f08-9f27-08da4d4b6cdc
x-ms-traffictypediagnostic: DB9PR06MB8560:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j4tGqtWnKoi3E2tHj+dIoegrZMYfCLevsJlCd52AuATfzr5EfQKJ7km9zfmHcH0YHxR+q2fVrvw34+3h+xaBjLWQhbp/DiXiRBGZU8VjUnmqzdceuntpgX3RxpRDc/75zM0SdU4qkx/PVjV9OxxDt8nIIz1ZeiCVEGldBzmQpiJRejPPO+v6vxZg2Hku3EQsvmVdhmITSgj3AnffJwUEoOtOIhdz0Ng1Io5z4jN3xfwzPV+zvWFQgNZobOqghqebPS7be6aRKnlO4/tgSQWPkeeDnaxaIWJOn0ge0F8mIt5q/mXtAqzSttzrCqCnGIkGn1VvuT4KggTXLt8RbT5JS0gytkmQevlpl6teDwCGxon+rojb1uTR48pU6yYY0o/FIQDZb/gC8fRNpiFF4noe6cjf0Cgv15rjLhmU88t8f8eI8tkUKggpXrXdkXgOuortmwIpnFdYp7vANrytxfLs3lp4/caQiIc4ZH6gw4+AOKVWXuR8YHPYso4780sl0njQ3fpSTviaqx1NYN1V7m9K/dX739C2cVo/J1xg8UrS9M6Q92KauJIHYpH1Uh4/+nwcN+h9PFeu45VPK6a7JfR15A==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TIIw8wxx+1o4cDVJgHXBmGOX1M1hZrqCBuXru/0RdGEb9jfPNpD5uVOXG5Vd?=
 =?us-ascii?Q?9izQgqNrXMK0cf3BMKIPOviitoOuLVcg+HqYn5/yE7uCiFmWC9i8/i7fcOk0?=
 =?us-ascii?Q?zQraTvfvZ83BQ9I2HRBvCs07eqMNf9tlcQF4pgLf3HSe130TVMIzBClKNHTP?=
 =?us-ascii?Q?pHuNzUqWh4RWtmgIwAuBLYV25V8urYUMLnjw03YHPZ/qm3VOCn+pG7Bjj10b?=
 =?us-ascii?Q?zsXDXyQdKQUk5wNpz9lkaWEAn/jrRGX6KWq1bW6PKtjXAMKU5z5Biq9Zp442?=
 =?us-ascii?Q?pbPT4HscN1YE6urzHZx9fmRGBk844ewchHeHTp7Z37vbTMSkbAyUTyI50P5y?=
 =?us-ascii?Q?UrcTpSdGfYHOeoSpFFtN5HKvEaLPBDIQRmNtIryUiuUrz1hxzNI9ECdJv5zH?=
 =?us-ascii?Q?fTYGuzb+h9BabQYS4OYnwsL9Y2HVHxtui3RTMzRLn2DT2Z576zJVQyqtrDSh?=
 =?us-ascii?Q?cgfTrDvSrEDajFCep1iMB2oNIZQK7Q39TE5JSfJzcRAqHAp1SjoNkBcfo/n4?=
 =?us-ascii?Q?NcoXtrgs4aQ/HUZ4wFhfJStnf+s5BpyMGe1+P8annXpsLnYixW4tGkH1EyqP?=
 =?us-ascii?Q?yDUl8a4iblV6Fuj9vJ6SAE+17MvkDa+1F61uOPVlqbLudA7DgGxtt9FlhBVh?=
 =?us-ascii?Q?lvk6oDNb+/wyZ53aSPWSq7IxMUy7WGkREYakCN5xfjSDOi34YLqBoeD5VnHQ?=
 =?us-ascii?Q?dGY3j6CdP48C4uVJRyvOgvCsTaMbsp1gLLdjfunkVBlkL+rFADzhJiGZCOsq?=
 =?us-ascii?Q?jy19xQMTyTn15RZIbwlYI4g1GcfK35xzAE1f5DJ9SAjLzNDYFeomqHvft10W?=
 =?us-ascii?Q?hAkgT2i9JF/vCxDhiKX8RtZIjPgQxUnhek9nTBGfD65h1EUoTpWewDBa91wB?=
 =?us-ascii?Q?b3n6CLAu+nu4476ZIJS+5r3H4oBryZ9p26sQwT8ycmEY7poCj78eRDG4kHMH?=
 =?us-ascii?Q?92a8mvqCI/o9yuCvHJ0vj4zFTnqS/Twq7IvELUuxafhCcBxb6S/o4SdVJXX4?=
 =?us-ascii?Q?Se004D7hKGW0G9bYT5olut6IMOqrAva6m97k3phdWEb5cfoDJDRALNE4W1d8?=
 =?us-ascii?Q?nJi4dtmLv7NzGdkhDUmUMpJAEYnKPQx5uVB4xjjT/GzW7Qjdc9GK8zCQucrW?=
 =?us-ascii?Q?m6chUjGA134pEzpVgryNfunQZGkDo+/BPiRqzeiX0I9E93el20m2+3JsAbwE?=
 =?us-ascii?Q?+IUlnu7lbzYlwRCJ6dt9oAu3NdoHOBR/+4efy6pVw7Dx6nLH9YoSAUTC2B41?=
 =?us-ascii?Q?3MGOHHvIdwZ1tIn33LFTEazBh0PNtxzQ5C63lQaz/qIBmphoooxQ+emRHQy2?=
 =?us-ascii?Q?Xrwm8hSwZSIk1COE0xaS1tDPaJfjT5VHPMlFhJbUrESy7XWxAy2muTJQ0P4o?=
 =?us-ascii?Q?va9M2+vTnHDPMgAZPYXF5DvQsuUxq07ATx+2oXg1DkioaZSD6F49WZArn8Oi?=
 =?us-ascii?Q?AFqXCTUEgJf+nlETkdoG1GaJkUykw4+AYXGMk2tGih6i+TFsv5+hoAcZLrlr?=
 =?us-ascii?Q?V+zttNDG8d3ck4I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0602MB3674.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b03c5eb1-822d-4f08-9f27-08da4d4b6cdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 14:45:57.0474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB8560
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Von: Michael Kelley (LINUX) <mikelley@microsoft.com>
> > > >> > > > >
> > > >> > > > > Issues showed up when I set up a Kali Linux Guest. I
> > > >> > > > > missed the memory configuration before booting up the
> > > >> > > > > instance, so it started with 1GB of memory, and
> > > >> > > > > ballooning active between 512MB and several TB of memory.
> > > >> > > > > Hyper-V started to allocate more and more memory to this
> > > >> > > > > guest since the reported memory requirements also
> > > >> > > > > increased. The guest kernel didn't see any of that allocat=
ed
> memory, as far as I can tell.
> >
> > Please do not forget about this: (emoji-pointing-up)
> >
>=20
> Hmmm.  Right off the bat, I don't know how to fix this.  Hyper-V tells th=
e
> guest "Here is more memory".  The hv_balloon driver adds the memory (but
> doesn't mark it "online"), and sends a positive ACK to Hyper-V.
> From Hyper-V's standpoint, it has successfully given the memory to the
> guest. But if the guest hasn't onlined the memory and isn't using it, the=
 guest
> continues to report high memory pressure.  Hyper-V assigns yet more
> memory to the guest, still to no effect.  Having the hv_balloon driver de=
lay
> the ACK until the memory comes online is fraught with problems, and of
> course Hyper-V has no visibility into whether the guest has onlined the
> memory.
>=20
> This may be one where the guest configuration really must be
> correct.   But I'm open to other suggestions for a possible solution.
>=20
> Michael

From checking the drivers code, it looks like the guest tells only the free=
 and committed memory, not the total. I can also see considerations about n=
um_pages_onlined in the committed-calculation.

I see 2 possible options at the moment: Adding num_total to the message (ch=
anging the protocol), or stop reporting if the guest fails to online memory=
 after the first increase. A third, more complicated option would be checki=
ng for not onlined pages (I've seen functions for that in the code) and add=
ing them to the free value in the report.

I'd love to write a patch for this if I had a clue how to test and debug it=
 without rebuilding my kernel all the time.=20

Flo

