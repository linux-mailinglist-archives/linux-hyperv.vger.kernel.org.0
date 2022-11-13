Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E4C626FA7
	for <lists+linux-hyperv@lfdr.de>; Sun, 13 Nov 2022 14:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbiKMNMk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 13 Nov 2022 08:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbiKMNMj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 13 Nov 2022 08:12:39 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11021023.outbound.protection.outlook.com [40.93.199.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E684B7F7;
        Sun, 13 Nov 2022 05:12:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgFUaShGcOXWgmw3wsVoio60aAEKFv7CQuD+ONoVCOwWUunVG1+vzKpW1ST58FgLBKGcKr4og4m8aQ2cuUETQED/lQK/P/WzjpSsB+9hpflv9uKSLwWBxIxG96nFNjMivM15eBdYacEyAkWmyu6rgM9Sd8Sa0w74NSzLmDOGLY0CBberDW8qE3P2RiwSHVCZDbFMjbfJmLfo6df3umoLgCOcqdn2nj9RhsNsl+YDulIItLQ0wzxtb0mLjHoRcrX9xzQ+YTXeDxp8cFZjfMqzHKw7574NJf3st6rDGgs4nDn36DWFLgtC7Cidlg7NMEacBgluswOL7iNwUmuIgIa9Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+z1xrdZ2u+zp8D3PBck3a9HN95MUd4OTsd2CkPiKV0=;
 b=JIrs+E7x0a9Fj+ejziKfpjgP1kGQuTWPvQ8rolDVR8pGI+b7zWASM7/Q34nY+NnUVWAyLpVCP23LSXcie4RyN2vXhBfWoKWEHi8WhFjYYm1QlMbA1ecRt9PG1cPnnmRnaDxCEZmyaZ63KlbKMgZj7RODJw++DZYDI/yCAD6N1BFhq55802G9QrsKQx47eeLWfO0+AnX2M3x5YmTZ+YO5SuggCbskErXT72ah3LGT8uor3ygPtCyodNy5tBMDjotCxLK9JwRzo8WB4CCZBRuYPWL2YvXlD0lUisj02biAMQRRo5I23voue22tfzNPoA5jGgoC68+PtJLhjchjlA3bHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+z1xrdZ2u+zp8D3PBck3a9HN95MUd4OTsd2CkPiKV0=;
 b=SseHb0kBhABBugq9Q+XHk5AZRrm4jOX3rhi6z/0ltHCWph6dbQ+w6P1t1stv8jhzWRI/UHcE/Xbp9s9vYMimGGJLAFaxJkXaWN7ISYQRSLYqDuZ2ACNKPgZJXpUUipWBnQmdPY/8heCj8j53TBlVBa+hOVFoAZq1+DYG5NaaMwk=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MW4PR21MB1939.namprd21.prod.outlook.com (2603:10b6:303:76::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.6; Sun, 13 Nov
 2022 13:12:36 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::6468:9200:b217:b5b7]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::6468:9200:b217:b5b7%3]) with mapi id 15.20.5834.006; Sun, 13 Nov 2022
 13:12:35 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: RE: [PATCH] clocksource/drivers/hyper-v: Include asm/hyperv-tlfs.h
 not asm/mshyperv.h
Thread-Topic: [PATCH] clocksource/drivers/hyper-v: Include asm/hyperv-tlfs.h
 not asm/mshyperv.h
Thread-Index: AQHY9slnwdraMHlbf0CZaajLWUgExq470lCAgADKxQCAADZyUA==
Date:   Sun, 13 Nov 2022 13:12:35 +0000
Message-ID: <BYAPR21MB1688DCC2BDD263042B499D84D7029@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <87zgcwt2qg.ffs@tglx>
 <BYAPR21MB1688C5BCDF3269BA070DB884D7039@BYAPR21MB1688.namprd21.prod.outlook.com>
 <87wn7ztc89.ffs@tglx>
In-Reply-To: <87wn7ztc89.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=88687241-bb66-4015-9cf1-7e35d92f6573;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-13T13:05:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MW4PR21MB1939:EE_
x-ms-office365-filtering-correlation-id: 171f9ab4-bccc-473f-7aec-08dac578bb78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +q+vxl0LSPVxLRzwryL2KYwqdhD3QV0JnbQ4nAR8rpGsexefdozfelgeHMSelwdLTUMsi2vvxCahUGcWp/r5ptT23dXUBM4rCPDJPIjma+Jh9GjWubt4nd508eh1qagDJSqseMhMBkv/y95lKptMNw9nnKMKUQrByX3ErHyEykd1ug/rsqaJptGoyOlevqgeDye9E1Cp2rmWPVreoWhgi5cRWUpRtuGiY9UaxTWsjSbQQGRlDCzzFvUIs7Oe4+St7FxpKOmlx/ZhpU8l5Fb75+gByF+ooKF4rRCOmjN3Iwv6ZEx9tJkypBB0i+/WYwAkMZC6lrbmSaC4NksZ6LEvt6xqfAG0S0+66WAd7hJoUZ0ioRHSyKRzAkY78pSezQXLEa6ynRc7T0Q5gi5aQNa0yJ+w2GLd9+aJVN75G1QRCa2Q24Ha79AoiXzy2+JzGr5ruUPTwiN5eXSn4jvIH+m8olioP4LCKw2quowzDN2h7zDDnixGgP1u/UgthNvGjwzv/bEJvkkUwn2oN92ZzVk7T3Fo0kDjy2WVgkuXphBUrknypB5GWt16seUEWQSTlT1Ansp9KRpvzfmPxst8NEtn+wzC4PpdY07tipAmIeePxC710WJk+69+mla9dRRp09NE9peF0Joy+muEb/w1yVEjGFxC4j6Z3o6GFr1erjQ8lEmRvx65dwmDlS5KCRi0lxe6v5qJ0SxTQv770jOX7oH95/z9KKtIr9MITifKKAoAxlkeiUoctWnzdIQh2xtyJ1no0jiHHCTnmhm2SWyGAd6oTUNMxI9tClM6xutU6chb6TTGhwV5SiTsYt67wbxoqlYl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199015)(66946007)(82960400001)(82950400001)(38070700005)(52536014)(66446008)(64756008)(66556008)(66476007)(478600001)(122000001)(38100700002)(86362001)(66899015)(55016003)(186003)(316002)(8990500004)(7696005)(83380400001)(110136005)(54906003)(41300700001)(33656002)(8936002)(4326008)(8676002)(71200400001)(10290500003)(76116006)(5660300002)(6506007)(26005)(9686003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sqeyn2BeagORHDxnW9YzeyCjuMO6MsyHV/zqY63gEaufxXb0w84i1BD97+Tu?=
 =?us-ascii?Q?009+x539zTReVYbsHG2LeEIujoF6QpgThy4q9x1kZLbdv/tgQ/4phUg/HBtY?=
 =?us-ascii?Q?cHgSJWZkWxWCflhO3V+w+q5yhgeaXFIOJx1AMybefx1GS4LoWLCV4vA8yyC8?=
 =?us-ascii?Q?yJAiHDV+GjTH2CuOzGdnShUbVTsIXHbo3++oRTTO0/qO7OdnIoQpnKabEVMn?=
 =?us-ascii?Q?rouC1gnxAMl4qOFsui8QogH48bvbSFe5yOl6d1eKjvS3PGwy1bTxLgkQFesT?=
 =?us-ascii?Q?HN01V8/iig1YyEJgQo4jBd4lNinsVz3QS18XS+bZ7JamlM6M0jAMI0PLswOS?=
 =?us-ascii?Q?Ju1BXfqIGcQXF5OW4tEUFrQuziIBvVYbNm6F4HvnkH1bqkvZGdRfaUXOUR2O?=
 =?us-ascii?Q?ArVlS5NWewR/HxY7BwP8MjVGqXgvpGbMwsk0FUk5XXgGDd0VilP8WW1VdbB/?=
 =?us-ascii?Q?kCiI2Z7RHcWauTg7csNa1d1pXK9DsYSVCTZuAE5Sim0aHG7J5/8VItHQOQs/?=
 =?us-ascii?Q?K35KQj8sMO7X+tYlo4n6gCjh36bHnzLzOAj+zh5ffFigGX9QxpatrSs+fG7K?=
 =?us-ascii?Q?oKAaVBhoyXA6Bt9zlgfpXvxqP4dPtoJYyG2jICA+iceMLabDIL5hkzf7wB8T?=
 =?us-ascii?Q?8zHn6bDXp3nCZpPvXmjZ7vAwItYY90EZOc9JsRxghbMP1pgKHVrdt6edUYeN?=
 =?us-ascii?Q?Tak1nTRqxSOKPYQMGUtjkrI2IQ2WrRWe+EuhjzU3DQGDeaG6//3/TsiN9aaL?=
 =?us-ascii?Q?JJV1w9136RhNP/H7FW7I6F6anrfWcmQkpI7LbPjPqDvRTPBr1MMY/RrktrCu?=
 =?us-ascii?Q?2xDXoSg1CQiOpZ2uPTTrpmMt/a67iSmGdDSiUM0tP6pfVZXjqnSzW+L44fv+?=
 =?us-ascii?Q?C2gEfapL79avoMvR/EMCyipYzffKVPVhjGowRdIzNFeU68gpwAvU+tJMWr2p?=
 =?us-ascii?Q?KtjHv4iEcckX2NlrfJwktW0z9ccGjlheq71z39IfTL5QbFPTT7AaAytYSmb3?=
 =?us-ascii?Q?OL7btWhA+jQwac0WCOlVhylvvVbv2uOfnDpmMEoxPiNc2LD92knBLhiJVvcV?=
 =?us-ascii?Q?opI5xE05fe18zUNCEE8i4c+gCypp//1Q3WBP86Y1wQREAF3Zjp8iXKk75yf0?=
 =?us-ascii?Q?L8/ze5O4RJWgczmc70PwNanSpSlW45U9zQ6K6eXLHBGA/3lB2cEjD7aVI2wz?=
 =?us-ascii?Q?M5XMXGwS8Q3/Nj2acExJzXii5AGpzjCdn9DW4I8pY+5DZ41w8WnQgNn2JmYj?=
 =?us-ascii?Q?Rbun+zNLpIk9KbUozsTPvDLKmBIM+6MeZTvI6SNn6a+ZjA3aI1CLhEURRfXF?=
 =?us-ascii?Q?uv699N4yvhCGxIhwZqnbFerAMUHiaCSyJvkMVYgcbRLsn4+EksHeYQhl7zhC?=
 =?us-ascii?Q?LMskdTeMh0/Wp+mqC9/REZTCMoheNPn9lZS1ChAuW9JuMc+f3TPWQTu3QgJh?=
 =?us-ascii?Q?ULokTattW/0F+pDlxybxv+U1DWT2nL9bn55m13jS6MStH8sAzC2+2plDDs8W?=
 =?us-ascii?Q?5PloVfEvpZDQGvjHRLu9yTBtRNfi8vwYBJDqLgJ+NqjYXcmc3QVGlxHZOUWD?=
 =?us-ascii?Q?xBfsqKtVz6M/pHPSrI8GomCYzFERus77YWexoyw3pCerr2uF7z07P16VBgG0?=
 =?us-ascii?Q?OA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171f9ab4-bccc-473f-7aec-08dac578bb78
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2022 13:12:35.7860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KNu4jArqVw3G5wVEh/KC4C8Wdd2ayVtxmUD1L/dQ4Yr3QuUF+vSBJDGiL45alFTvMay1j7oLo0SPM3KBuAgMFsGx3sjiKq/dLWZqtz0rCfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1939
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de> Sent: Sunday, November 13, 2022 =
1:50 AM
>=20
> On Sat, Nov 12 2022 at 21:55, Michael Kelley wrote:
> > But I can see the problem with too much getting dragged into the VDSO
> > builds.  If hv_get_raw_timer() is added to hyperv_timer.h, it should
> > be under #ifdef CONFIG_X86.  Adding an #ifdef isn't ideal, and a more
> > more proper solution might be to have a separate hyperv_timer.h include
> > file under arch/x86/include/asm.  But the latter seems like overkill fo=
r just
> > hv_get_raw_timer(), so I'm OK with the #ifdef.
>=20
> We surely can have asm/hyperv_timer.h but TBH:
>=20
> >>  static inline notrace u64
> >>  hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg, u64 *cu=
r_tsc)
> >>  {
>=20
> hv_read_tsc_page_tsc() does not look architecture agnostic either. TSC
> is pretty x86 specific :)

Yes, the naming still says "tsc".  But there's nothing in the code that act=
ually
requires the TSC if hv_get_raw_timer() maps to some other hardware counter =
on
a different architecture.   That's why the hv_get_raw_timer() abstraction i=
s there
in the first place.  If we didn't care about x86-isms, hv_read_tsc_page_tsc=
() would
just directly invoke rdtsc_ordered().

Michael

>=20
> Thanks,
>=20
>         tglx
>=20

