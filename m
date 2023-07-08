Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8343D74BDDF
	for <lists+linux-hyperv@lfdr.de>; Sat,  8 Jul 2023 16:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjGHOhh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 8 Jul 2023 10:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHOhg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 8 Jul 2023 10:37:36 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020016.outbound.protection.outlook.com [52.101.61.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13137E56;
        Sat,  8 Jul 2023 07:37:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vm/KrSwHp7lHfzTwwxgvh7XboCE88ukhK/le1kpdlZi5L4322f1IEGa0J2sq+zQM8ywB+d4K6BY5yywfZcBc6PCUjM2rPOxYksE1pfUe5d5Sa6yps4igL58G3qBm6KKjDn+TIwUqHLs5AufxtOXDeWc4V1SGH03EpmzMZ+NjQTw9ZyGy0IcCYKqULczOVTAK9PL8p/hN3PySI9QET/oJbLqsDqm5p1Bh+oZ+5oBKleBz752564zznWbYsiQZwfC0v3NQxUxUqJLBmGR7jn//bUsWDfdcwE7RR2REIdkrVfqFh38HxdvvF2d9XJEnBA6xgjBpFDgKRgyp56OqxlKkfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuBt5+wMhiCrphCcMIJiLv0EYchhCVRfBdVc0JpZMQQ=;
 b=czgLwwVtWKt6VVN27DOkxaVYTF4SKi4tR/uIalOaa1lH/I9SwqmADnO3xMC17GEBD433Deer2rbGpBu/Mue4H7qn5SWzr/a21NJTzOcFS/xhcYoF1eXrIzCt2UTSTdZhXcGPPR5TBU6FwQwhoidBN6sMxa2UwJxtWGs/v+EDrAMOOVUkqOvKEcKD/LMRRd6aPsPK5jbwSNKiONGwUh+O6Ov7d63FZTKnnawMposfnbo+AFlVYEhgSJ/Fcofir0Iw30WJf21iXqurLSNvy7EYVOxSUfXyc4AzibRU7sMVkNhNXtNg8r49zb2FSG5kSgyWHEJVrlHB9urpyMMEnFC+Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuBt5+wMhiCrphCcMIJiLv0EYchhCVRfBdVc0JpZMQQ=;
 b=eImevsG0z5nkBiykjDT3tD0JiC8TFnD0PlmUgwrTh6CQNAR4VQMiVbjISHJDuQXDQEyoQBQR/lBJI9SVJzesAmlHCeWWNuWZX6wqddqHn9bv3uX4/+3saWbAsOTWEsSeYn3RCWc96FkfpZg8meU0ZGlo/LDUC1Zt5jqVW4CW1X8=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN0PR21MB3583.namprd21.prod.outlook.com (2603:10b6:208:3d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.14; Sat, 8 Jul
 2023 14:37:30 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::733d:6263:4482:ba25]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::733d:6263:4482:ba25%4]) with mapi id 15.20.6609.000; Sat, 8 Jul 2023
 14:37:28 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Arnd Bergmann <arnd@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC:     Arnd Bergmann <arnd@arndb.de>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Dawei Li <set_pte_at@outlook.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        =?iso-8859-1?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] HID: hyperv: avoid struct memcpy overrun warning
Thread-Topic: [PATCH] HID: hyperv: avoid struct memcpy overrun warning
Thread-Index: AQHZr0llfkBz0jWXH027nvPaFIvXdK+v9I4w
Date:   Sat, 8 Jul 2023 14:37:28 +0000
Message-ID: <BYAPR21MB16880FB07E1632DCA991A59BD732A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230705140242.844167-1-arnd@kernel.org>
In-Reply-To: <20230705140242.844167-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e5f54eeb-8e83-42b1-9cc3-0abbdbcd03c0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-08T14:36:21Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN0PR21MB3583:EE_
x-ms-office365-filtering-correlation-id: 301e365f-2e21-4455-ebe9-08db7fc0da99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tg/EyQrGRK0jkZn9UBcAeXpKj+RRAUel6MHxNPjIVJsWZLEQLoEF2wEWZwRUDRdKS0/+qWFPjYEd3nj50o2jfWRIeYxgZ1SFFQ2YBQkjU9WWppAaLMgiZykvKFNclffcMb5q+gnLmYfnpstML5imQ/iin1wjq4w1aMjFB7pPhuUeqissFpiwzDUCv9xb/X+j/SKw1Zt3OaR/1JP2qIw9AOrnV7AeaWWhiE3nYgCj/GL8tqHN7xxYRZzYCt40S882Y1LKoDqFUNUEr1YCUPDw+GP9wLkuQB02kVmDlpZJmhnFuJDM2u+pQqeXYM95xwsHXKMsIOEGbmUHxGkrtF55zKlVejZJAg7GINojhlDm6eQsVPeAITGBFlVJvdeCGCWFRJIHFAyuo/2v3qzklcs3C6ZC1hCoMD/QI2EdUY+I32U6rq/Eoywqia1nNo15i3Rj4420v/DDXeyFxIZUh5iMaorAOoN+yjtbdNMtidG6qICVi9KIoJYR7QnSBWfHudAm7bHGRk3d2ow+DyVF4qXMvTHmQrEGaHIf++maVokWTezAZRpxkQKZM9Deoccd/nPKo1Oxm46gSK0HhC0ErgAJhukss/H/ZNzeCHwAhoVFlyPARJ8c5ZvjxFByQYnTE4njH0PC6Uf7Q0ngQP3dVNd8ki2Eqp9VBdRVsTHOJjBIrRo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199021)(10290500003)(478600001)(7696005)(71200400001)(76116006)(110136005)(54906003)(6506007)(26005)(186003)(9686003)(8990500004)(2906002)(66946007)(41300700001)(316002)(66556008)(66476007)(66446008)(64756008)(4326008)(5660300002)(52536014)(7416002)(8936002)(8676002)(38100700002)(122000001)(82960400001)(82950400001)(86362001)(33656002)(38070700005)(83380400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jDV/pkq6hyyKTwN/WlMndNnERKnZZsb3bLJ1rJnBX+YCSyqt6Al71YzmU9?=
 =?iso-8859-1?Q?wad1oQpktnabHi9GlLHaNtMTT2KODUTCHUpQFSonY26ZYh7Wnkt2d1KDjC?=
 =?iso-8859-1?Q?shHppTw14R14jatBKCJnht4zAkeY6KMOPCE44Tlw7c7Csxp1cobzqw68Sa?=
 =?iso-8859-1?Q?HEH1yiV1Ji6U5B3J9F7XC/tV5z/fedLF0RnEOAJaoFBwM7IgHWwNtRj7un?=
 =?iso-8859-1?Q?zl47c1XVZwfEyO3UFZx5zSt763UL1eh8MxYoKWjX9eszQVLIBPE+U61Dtu?=
 =?iso-8859-1?Q?XU70Y+HcLD9WYfiGPuKdhf9Rj+dqlCxKETiAC6Xa7vflOTa0vMhwLAU0X+?=
 =?iso-8859-1?Q?4jtN4Az7TM7Ls5/VntQVI0K/81cpeTkIUXc4XT10uI4WkkgVOcmmxQ7R0V?=
 =?iso-8859-1?Q?ct58ohqVJRPUBozUvrMZHdp9f6oHKxxB4mBG/LEMxS76cIaJy7Bviybkkz?=
 =?iso-8859-1?Q?63OU3Lc+t9cTHxOzPjIwTxebNw3jpwLdvlxK6VO/JqHuvvGdHWSBSfCDXT?=
 =?iso-8859-1?Q?173Lkjn1R4TqDqRMdsdzqP9TFN2ZrZ8emA9QhYJEePFqG1OmPE87tqfXja?=
 =?iso-8859-1?Q?HZbjnIh+PzYHRDHmH/FohdwygsWxw0b/9zCUsiiJAPelUwPitngvO/KOvF?=
 =?iso-8859-1?Q?x0oL9IapE5+YFr4N8sH2fEndN43clLHrLoTmk++j3R0T0BsrDgvsM9B7v5?=
 =?iso-8859-1?Q?ts/bqXC+e8HkcZMVocMu6vHbiEc2fNxy6T91YvqKiHy4+2SWx2LxOmA/Y/?=
 =?iso-8859-1?Q?/9z+Hq9fP8RBVEmnLZgTS9R7UtbLVx3KvxD3qTuKZHhNzhSUi7jcixbAt5?=
 =?iso-8859-1?Q?KAUR5nMtvU66OkBTmIlpsf2jZGNH4SH6SwVI0HnHiY2sEKAzZyuHJIC5pQ?=
 =?iso-8859-1?Q?Be/+Z72SLMxSnKnW6Dqv9kSBofZZ6FYWH8x+nvxi+gW0yEz+8MNRm6wzI8?=
 =?iso-8859-1?Q?2ZAyoiu2i3XuKfWeGn87zBJf87PZ+raXsZCK+G9ig0V0LpsaOh1zYRyyqk?=
 =?iso-8859-1?Q?pfCiYlC4JdWCxQaGa0AJ2CzV7M+a55Gq4v4LBYKH6ejDoVva5k12BGYdPP?=
 =?iso-8859-1?Q?B7CLWnTVY7hnXNGPRZGNgvK7G1tzXRjXv5B9mLwl6oamMdWm7sR3gGwp5W?=
 =?iso-8859-1?Q?OtsMctTMWnFpcfr6EtNU7sf8kvzZ8D1SCaQwOkuhweIYAPbxxkGaV33IOI?=
 =?iso-8859-1?Q?7iS2S1dQd0hFujQ47CHkq8UcNk/OZLwpM4nWG0pHZoMVhEhbcSzeJuWl1H?=
 =?iso-8859-1?Q?OG0jv4FlcHIyQZb6Y+UGfCOEdZ3/0nzqK9xjvOfK73QOCo3yRRSy9irkOd?=
 =?iso-8859-1?Q?bphGSY1a+gY8IfG+qME4+qgpXia2migoMhCbgc1MOe1hQM9LYgL5emkPM3?=
 =?iso-8859-1?Q?uUEHJJVQmLnbFHUCBq1418HlW4wcgmI8NOvunCeBvKvaOn478qJQNL5t4E?=
 =?iso-8859-1?Q?IDbuSyZhcUR/VCOqB7PWFo5gr15FeIl9MWSa61MDnCByT5+5qG+sllOTwz?=
 =?iso-8859-1?Q?vktJieGf8WwWCjCWtTIjNkmpNMstN8bL4FqI1H3dXylP5Qq0sqCQDNDleu?=
 =?iso-8859-1?Q?qZh7afILC6OCq7Nq/SBfNqK3h6jCMqrwEIbWJ62CzTjgqi3ThJ5Cpitxg7?=
 =?iso-8859-1?Q?ynNGtc8gBNwupCJohcc3KDsmIhDIz5yVEGSrQjqN/sByaY11veuua06Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 301e365f-2e21-4455-ebe9-08db7fc0da99
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2023 14:37:28.0691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KTyxm1XrYK67EFK0xScq0miR8GH+KR45z2yeHU1n9n3wx7omPVSXjYCab3Olbm22GV6lN/5RFrVLeJ2ZBhixRDJtwc71ujVErbthVjmnwy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3583
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Arnd Bergmann <arnd@kernel.org> Sent: Wednesday, July 5, 2023 7:02 AM
>=20
> A previous patch addressed the fortified memcpy warning for most
> builds, but I still see this one with gcc-9:
>=20
> In file included from include/linux/string.h:254,
>                  from drivers/hid/hid-hyperv.c:8:
> In function 'fortify_memcpy_chk',
>     inlined from 'mousevsc_on_receive' at drivers/hid/hid-hyperv.c:272:3:
> include/linux/fortify-string.h:583:4: error: call to '__write_overflow_fi=
eld' declared with
> attribute warning: detected write beyond size of field (1st parameter); m=
aybe use
> struct_group()? [-Werror=3Dattribute-warning]
>   583 |    __write_overflow_field(p_size_field, size);
>       |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> My guess is that the WARN_ON() itself is what confuses gcc, so it no
> longer sees that there is a correct range check. Rework the code in a
> way that helps readability and avoids the warning.
>=20
> Fixes: 542f25a944715 ("HID: hyperv: Replace one-element array with flexib=
le-array member")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/hid/hid-hyperv.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> index 49d4a26895e76..f33485d83d24f 100644
> --- a/drivers/hid/hid-hyperv.c
> +++ b/drivers/hid/hid-hyperv.c
> @@ -258,19 +258,17 @@ static void mousevsc_on_receive(struct hv_device *d=
evice,
>=20
>  	switch (hid_msg_hdr->type) {
>  	case SYNTH_HID_PROTOCOL_RESPONSE:
> +		len =3D struct_size(pipe_msg, data, pipe_msg->size);
> +
>  		/*
>  		 * While it will be impossible for us to protect against
>  		 * malicious/buggy hypervisor/host, add a check here to
>  		 * ensure we don't corrupt memory.
>  		 */
> -		if (struct_size(pipe_msg, data, pipe_msg->size)
> -			> sizeof(struct mousevsc_prt_msg)) {
> -			WARN_ON(1);
> +		if (WARN_ON(len > sizeof(struct mousevsc_prt_msg)))
>  			break;
> -		}
>=20
> -		memcpy(&input_dev->protocol_resp, pipe_msg,
> -				struct_size(pipe_msg, data, pipe_msg->size));
> +		memcpy(&input_dev->protocol_resp, pipe_msg, len);
>  		complete(&input_dev->wait_event);
>  		break;
>=20
> --
> 2.39.2

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

