Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E73F532012
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 May 2022 03:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiEXBCb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 May 2022 21:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiEXBCa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 May 2022 21:02:30 -0400
Received: from na01-obe.outbound.protection.outlook.com (unknown [52.101.57.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD05E9BAD6;
        Mon, 23 May 2022 18:02:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dx26PUpchc+JZEETYRNiVTNV/Ac6jkaAlSXLRIlt9RjnRqeAyI7JuMiJFJFp/cNMY3CzrfLnqFn3VgH2j4Km7z4OvoPoow9AFhPXZWmxtFFWLelTwTazTRP+tdSkXUVffAEkLgmTu7BsCRFylOw8tLGNr3022vCKRyB8j/NYQcorz2avC9e9xrAyqyYmyF55sEMMFgX8DlbqsQTIPBEzPIaq7KI3rZasKIXzJ+T4wpxGosxgbn4h2HNncEjnOuMdVBuB8veywc2rItyOJNHv0IteNJpWdDoCgOCTr1cxILa0hzI4uTXRAyu8MMb2pYtNO4EVnVhSryBHIBaHguhgFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvxC4AREBKz8IFsbR3hltKh2mxtBhQBxkmpBeR6BWrs=;
 b=ihjg555ga08F9TN4J7nAB8PGo8ujOU+/rstUiYCf67W4pJbgrrgdbidumk7j2IBmC8uaTFHZvCbir8SWx3QmSVxqGU2YYrp9v248FTtHr4K9hY6N/P3skhZVJomVoUDPGi7hm69r+fRcA+wrKuf05riCxblO9+tfHFhTb8bXzbtDj0AnbZZlgIblFDukFSd4aggOR0rkT6tuWYaW7BgL91ZX38NlvfI19jrCVRn4Cp/SLFi9NsSmoqVvueHo/46+VDyc5Fsk03UFdiyOShbj0JBIsZ52v1F/kFGGRTQ0a2Mc/a9AKzoQEY+WTaPEp0guPV3dLjMNtcSwin2yPWWPAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvxC4AREBKz8IFsbR3hltKh2mxtBhQBxkmpBeR6BWrs=;
 b=Vyy9C6Gh5ORpHQyayTr56GYI8CPny4hxufRSxwVeEMks5JnyWecaIkH5KqvsSnjEiSfLvFFTpqXX1bOBcHOpXaPrpg+74gh2HSLyOoUdC1+hPntuwWueEwH//ALqM8iUlwZGrWgkNAsshUXQ2shRdGEGmsDMsg0YqffZnrZpNtM=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by CH2PR21MB1494.namprd21.prod.outlook.com (2603:10b6:610:88::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.1; Tue, 24 May
 2022 01:02:24 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::3506:defe:c88a:8580]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::3506:defe:c88a:8580%9]) with mapi id 15.20.5314.003; Tue, 24 May 2022
 01:02:24 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Long Li <longli@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] scsi: storvsc: Removing Pre Win8 related logic
Thread-Topic: [PATCH v2] scsi: storvsc: Removing Pre Win8 related logic
Thread-Index: AQHYbqx4Ocxj6TRpwU+PggU07BF0pq0tMvmQ
Date:   Tue, 24 May 2022 01:02:24 +0000
Message-ID: <PH0PR21MB30252D1E47B4753D00E0B248D7D79@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1653313994-8139-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1653313994-8139-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9bfdbada-d3e5-4e3c-839e-63fd5d7f955b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-24T00:49:44Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe742d12-e27c-4207-aefd-08da3d21103b
x-ms-traffictypediagnostic: CH2PR21MB1494:EE_
x-microsoft-antispam-prvs: <CH2PR21MB14940E580236883B7F65D3D7D7D79@CH2PR21MB1494.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nFnQjhBrxPSTH3AK0enhrPxJddHcsnFZJ46ioMlU1YoZolCy78px1jlqiqY8OYMBABpp/VJxAl2EvFgzBDP+xm/83nzH+S4sdKFrep1aUqL3cK8kRc8hydkeJa80a3SDSEYfPwq2HIf3RCFhSjsGb23+t6nLpuoOhNbAAoVsTVHqmt9W4SiIgmetWuBzUjlHMHDHlp13BTJw+shbaTdWpGnQkYL7II9gw/bZd77ON0U3M180NDf4NP0TxcjP7pbF2PcxqY6N9fIO8sfuZFehQygRauzQD6QyW9z/LjoEpplAPeoRM/tjgZUS96m5hLvv6WdDIC0cb/yLK88pj4scHMfQnjyTNCAJBZ4vQ11bM7iPWAMnOoOB5OJOi1YQUjkR9lpaJpnxHfRG0TpWRqc9PMGrZ4g1QCjuDL8B7sM/sjZmgvcNFXZ9bd5zbODVbrIvfgy73vDnFwyvVU7leV5dWNXIMRCD4DLGxHTgIZElg/u2KoA5qwhsi7j6LEE6eQuCtOMhwoRQyuRLM7cLTQ9hsGNWa6+LI2lww2HzbXYtZ7zkc3aESiUYNq6xutHqI4JqU8ShUMzYQ460kvuLAEepqgZ6Jd7TNKNI5GltCWOwhvnFIWzPq4KV6urlukMe6rMHA8kNuS/kmpRgZx6fWhqFKi7CLE1j/mkezOkdGjJ1lt/AHAgedQOZ8tkNNlY8DEFsXxALYwUbsw5H4wmfqiqgTdRav1CGKf936eZR2B1zSv3wL5oRWBAqzIkd1TPFE5eH3jSIlu8fK4mLVcxykKs4fQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(66946007)(122000001)(71200400001)(9686003)(5660300002)(66556008)(66476007)(83380400001)(33656002)(8936002)(76116006)(86362001)(52536014)(7696005)(6506007)(30864003)(508600001)(316002)(82950400001)(38100700002)(82960400001)(55016003)(26005)(110136005)(38070700005)(64756008)(186003)(8990500004)(66446008)(10290500003)(921005)(2906002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N85ve8z5MbGvCjFAmQ9FaAEVdXlzH52AVIBjqCgqq4WnIVksGFlc/AjKSiSi?=
 =?us-ascii?Q?z7yVEaz3DEMSNIw5UaO+mvEN7AgBC9qwe7r6ggFYIIrFTm/5kfP6xl/FuQ7I?=
 =?us-ascii?Q?rl7DkRspAjEN7PK+bG+tiYM/XzsMqhTmW2se1FSYWqyMo4obA4q0b5jQUslq?=
 =?us-ascii?Q?ej1DhxssBFP+yRUPlNucWfzvyUwyCjPsJECbTQWUOE9r0HxMQZxyBs3/sBPb?=
 =?us-ascii?Q?B1SYfs5jXl6r+Ml96bXD1ySD8vviBFFi95yepTZo0FyK00HrxIRgEqQwy5YY?=
 =?us-ascii?Q?KobL2RLSnNGrk8JgdwDe+6Ivfmtv7gjeyXEMjWBU/YbPoi9+Uau9ooon7Ipf?=
 =?us-ascii?Q?ILMPgE0Jmly3+dC/i88E4jEi9i7dekGtZYdAM2Zc3fFNMGWTbNcCYCFpLIF6?=
 =?us-ascii?Q?Erkr61G1/TWRSb01q2vQTlhqOiv4eWkw0m+8z+P/28Eu5LEQ9CpRhYVL2/iO?=
 =?us-ascii?Q?s4JCjNCi85bVZX33zeERqKtVx7qlOkJbN4quFQBJKdx8+AjAo0d5+skqIqV4?=
 =?us-ascii?Q?kzwIIGFvHXVhVJkejPPDSGCKD/oVYRFPsYX9OiqPBDN4B91f79kOaHRKLTHv?=
 =?us-ascii?Q?KOdn5lNCnJ5Ut+C/m8+kSj59DyXGNuGS97u9hAxl6yDcMhmJBpBeimnldQV0?=
 =?us-ascii?Q?8g4h9trbqUlxKIR48MvuoeNvOWH6AG+M4uX/T/Ps/kry413JyFEVsGACyiSf?=
 =?us-ascii?Q?99L/EFDeFMIVgCTkpm2DwNr4uq6pmFlIFp4ND7sI1r+2Ptg3WlfLcD8ZBuul?=
 =?us-ascii?Q?A8C4jaCRtetgyl+OV55E5GaEsw2PKXCPI7quGQwzCwclAE4TDZxPcPf0BRql?=
 =?us-ascii?Q?b+w70JvO6A8R9aRXnV6X4jDzpyYuOrBv0u7iH2YgcHgnMR2OF61JNNvmOTip?=
 =?us-ascii?Q?C7tm/U6teGIvLRFAQ+jZ+dbuEzLPJX0bOz0zjIII3NSLqZIfL/2qU3BCQFFA?=
 =?us-ascii?Q?Fqk2RYbnF32zDC9VJsoFueEHlFdEVkkv8F8+9ZGpzY6bTpD2Mc8s50uEynYk?=
 =?us-ascii?Q?ZwtJ+RMizD3cPfbVgJy4NGQqAyMUeMcNvPpeaxx90iQKpYcp+5npI5Hd+6Z9?=
 =?us-ascii?Q?DtJHSzIb0ei1VM9nQfLeqgDmFn4BBOwuFqdsTIOWjqGrol5w+KxLuk231PwI?=
 =?us-ascii?Q?cHiuVyUZW+OoWJQknOO/AeH0APlXKbJs7z7HuhdHEvXuGCreVm3xOpYgtg2E?=
 =?us-ascii?Q?t9HzjsKkGh3BJJeRiruaGTMde9MS60oZhPWq0NaG36apC7rcTV4DH5SkcDCJ?=
 =?us-ascii?Q?vkpkJsH9UZ7EKfLm41amHczoBJHKtpqlMObB3a1hAJP1Al0t9PMSqPthIc/w?=
 =?us-ascii?Q?d6X0BMBwcuM20JAxSjeVBVtqV9f6RvPlX8NFjv4a3iefx3FhBPcIsNM6BURA?=
 =?us-ascii?Q?ic1ogSwiPdX7MM89Pl+uYYRg2M1mquoZ++zpHP29oMLKd4592Ih3l/MQ9Kvq?=
 =?us-ascii?Q?5jLP3/5oyDtD4vSex4MhaVp0wHgE9HV5DZouN/lCmoSOhmxbV/nNkAptAgv+?=
 =?us-ascii?Q?6RXHyI9Y002T+WTuDT5gZ9ZJcUpfpFgD2snOHbpkOnmXfvW4vwTGtZpD2dEl?=
 =?us-ascii?Q?5s0GsQ5BJEPK1ekxM8+L8njBzaIxrarM4X0Zd4JehRS6HzBkNL1afL7hst9O?=
 =?us-ascii?Q?9j6sFMbTUTHDVgp3/Ug74IMwA3hVnxt8cFO4LNh98i24pFclfQivILBwYnJc?=
 =?us-ascii?Q?aVfj93h17appYKtaBIxnpKdDd9taqTpQvJcNkYzt+zrYXmhvnkc4zovtSB3o?=
 =?us-ascii?Q?J+g88KmqKQVPPiYA9jsT1NrDABYEqwE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe742d12-e27c-4207-aefd-08da3d21103b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 01:02:24.1752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WQtxOTtsW6ceI7wZVDGh1hYvGy7oVtPvJQApBvakNFpW26TdTlhstWem7HyQdPgRYdsCAedwruFw/SXSzKV6Nw/kmU4R50QDDxzodc1swdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1494
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com>
>=20
> The latest storvsc code has already removed the support for windows 7 and
> earlier. There is still some code logic reamining which is there to suppo=
rt
> pre Windows 8 OS. This patch removes these stale logic.
> This patch majorly does three things :
>=20
> 1. Removes vmscsi_size_delta and its logic, as the vmscsi_request struct =
is
> same for all the OS post windows 8 there is no need of delta.
> 2. Simplify sense_buffer_size logic, as there is single buffer size for
> all the post windows 8 OS.
> 3. Embed the vmscsi_win8_extension structure inside the vmscsi_request,
> as there is no separate handling required for different OS.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> v2 : 1. Added error message for old Hyper-V versions
>      2. Removed a check "vmstor_proto_version >=3D VMSTOR_PROTO_VERSION_W=
IN8",
> which will always be true
>=20
>  drivers/scsi/storvsc_drv.c | 148 ++++++++++---------------------------
>  1 file changed, 40 insertions(+), 108 deletions(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 5585e9d30bbf..dd9cde6331bc 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -137,18 +137,16 @@ struct hv_fc_wwn_packet {
>  #define STORVSC_MAX_CMD_LEN			0x10
>=20
>  #define POST_WIN7_STORVSC_SENSE_BUFFER_SIZE	0x14
> -#define PRE_WIN8_STORVSC_SENSE_BUFFER_SIZE	0x12
>=20
>  #define STORVSC_SENSE_BUFFER_SIZE		0x14
>  #define STORVSC_MAX_BUF_LEN_WITH_PADDING	0x14
>=20
>  /*
> - * Sense buffer size changed in win8; have a run-time
> - * variable to track the size we should use.  This value will
> - * likely change during protocol negotiation but it is valid
> - * to start by assuming pre-Win8.
> + * Sense buffer size was differnt pre win8 but those OS are not supporte=
d any
> + * more starting 5.19 kernel. This results in to supporting a single val=
ue from
> + * win8 onwards.
>   */
> -static int sense_buffer_size =3D PRE_WIN8_STORVSC_SENSE_BUFFER_SIZE;
> +static int sense_buffer_size =3D POST_WIN7_STORVSC_SENSE_BUFFER_SIZE;

I think you could remove the sense_buffer_size variable
as well as POST_WIN7_STORVSC_SENSE_BUFFER_SIZE.  Just
use STORVSC_SENSE_BUFFER_SIZE in the two places still left
where the variable is used.

Michael

>=20
>  /*
>   * The storage protocol version is determined during the
> @@ -177,18 +175,6 @@ do {
> 	\
>  		dev_warn(&(dev)->device, fmt, ##__VA_ARGS__);	\
>  } while (0)
>=20
> -struct vmscsi_win8_extension {
> -	/*
> -	 * The following were added in Windows 8
> -	 */
> -	u16 reserve;
> -	u8  queue_tag;
> -	u8  queue_action;
> -	u32 srb_flags;
> -	u32 time_out_value;
> -	u32 queue_sort_ey;
> -} __packed;
> -
>  struct vmscsi_request {
>  	u16 length;
>  	u8 srb_status;
> @@ -214,46 +200,23 @@ struct vmscsi_request {
>  	/*
>  	 * The following was added in win8.
>  	 */
> -	struct vmscsi_win8_extension win8_extension;
> +	u16 reserve;
> +	u8  queue_tag;
> +	u8  queue_action;
> +	u32 srb_flags;
> +	u32 time_out_value;
> +	u32 queue_sort_ey;
>=20
>  } __attribute((packed));
>=20
>  /*
> - * The list of storage protocols in order of preference.
> + * The list of windows version in order of preference.
>   */
> -struct vmstor_protocol {
> -	int protocol_version;
> -	int sense_buffer_size;
> -	int vmscsi_size_delta;
> -};
>=20
> -
> -static const struct vmstor_protocol vmstor_protocols[] =3D {
> -	{
> +static const int protocol_version[] =3D {
>  		VMSTOR_PROTO_VERSION_WIN10,
> -		POST_WIN7_STORVSC_SENSE_BUFFER_SIZE,
> -		0
> -	},
> -	{
>  		VMSTOR_PROTO_VERSION_WIN8_1,
> -		POST_WIN7_STORVSC_SENSE_BUFFER_SIZE,
> -		0
> -	},
> -	{
>  		VMSTOR_PROTO_VERSION_WIN8,
> -		POST_WIN7_STORVSC_SENSE_BUFFER_SIZE,
> -		0
> -	},
> -	{
> -		VMSTOR_PROTO_VERSION_WIN7,
> -		PRE_WIN8_STORVSC_SENSE_BUFFER_SIZE,
> -		sizeof(struct vmscsi_win8_extension),
> -	},
> -	{
> -		VMSTOR_PROTO_VERSION_WIN6,
> -		PRE_WIN8_STORVSC_SENSE_BUFFER_SIZE,
> -		sizeof(struct vmscsi_win8_extension),
> -	}
>  };
>=20
>=20
> @@ -409,9 +372,7 @@ static void storvsc_on_channel_callback(void *context=
);
>  #define STORVSC_IDE_MAX_CHANNELS			1
>=20
>  /*
> - * Upper bound on the size of a storvsc packet. vmscsi_size_delta is not
> - * included in the calculation because it is set after STORVSC_MAX_PKT_S=
IZE
> - * is used in storvsc_connect_to_vsp
> + * Upper bound on the size of a storvsc packet.
>   */
>  #define STORVSC_MAX_PKT_SIZE (sizeof(struct vmpacket_descriptor) +\
>  			      sizeof(struct vstor_packet))
> @@ -452,17 +413,6 @@ struct storvsc_device {
>  	unsigned char path_id;
>  	unsigned char target_id;
>=20
> -	/*
> -	 * The size of the vmscsi_request has changed in win8. The
> -	 * additional size is because of new elements added to the
> -	 * structure. These elements are valid only when we are talking
> -	 * to a win8 host.
> -	 * Track the correction to size we need to apply. This value
> -	 * will likely change during protocol negotiation but it is
> -	 * valid to start by assuming pre-Win8.
> -	 */
> -	int vmscsi_size_delta;
> -
>  	/*
>  	 * Max I/O, the device can support.
>  	 */
> @@ -795,8 +745,7 @@ static void  handle_multichannel_storage(struct hv_de=
vice
> *device, int max_chns)
>  	vstor_packet->sub_channel_count =3D num_sc;
>=20
>  	ret =3D vmbus_sendpacket(device->channel, vstor_packet,
> -			       (sizeof(struct vstor_packet) -
> -			       stor_device->vmscsi_size_delta),
> +			       sizeof(struct vstor_packet),
>  			       VMBUS_RQST_INIT,
>  			       VM_PKT_DATA_INBAND,
>  			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> @@ -864,8 +813,7 @@ static int storvsc_execute_vstor_op(struct hv_device =
*device,
>  	vstor_packet->flags =3D REQUEST_COMPLETION_FLAG;
>=20
>  	ret =3D vmbus_sendpacket(device->channel, vstor_packet,
> -			       (sizeof(struct vstor_packet) -
> -			       stor_device->vmscsi_size_delta),
> +			       sizeof(struct vstor_packet),
>  			       VMBUS_RQST_INIT,
>  			       VM_PKT_DATA_INBAND,
>  			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> @@ -915,14 +863,13 @@ static int storvsc_channel_init(struct hv_device *d=
evice, bool
> is_fc)
>  	 * Query host supported protocol version.
>  	 */
>=20
> -	for (i =3D 0; i < ARRAY_SIZE(vmstor_protocols); i++) {
> +	for (i =3D 0; i < ARRAY_SIZE(protocol_version); i++) {
>  		/* reuse the packet for version range supported */
>  		memset(vstor_packet, 0, sizeof(struct vstor_packet));
>  		vstor_packet->operation =3D
>  			VSTOR_OPERATION_QUERY_PROTOCOL_VERSION;
>=20
> -		vstor_packet->version.major_minor =3D
> -			vmstor_protocols[i].protocol_version;
> +		vstor_packet->version.major_minor =3D protocol_version[i];
>=20
>  		/*
>  		 * The revision number is only used in Windows; set it to 0.
> @@ -936,21 +883,16 @@ static int storvsc_channel_init(struct hv_device *d=
evice, bool
> is_fc)
>  			return -EINVAL;
>=20
>  		if (vstor_packet->status =3D=3D 0) {
> -			vmstor_proto_version =3D
> -				vmstor_protocols[i].protocol_version;
> -
> -			sense_buffer_size =3D
> -				vmstor_protocols[i].sense_buffer_size;
> -
> -			stor_device->vmscsi_size_delta =3D
> -				vmstor_protocols[i].vmscsi_size_delta;
> +			vmstor_proto_version =3D protocol_version[i];
>=20
>  			break;
>  		}
>  	}
>=20
> -	if (vstor_packet->status !=3D 0)
> +	if (vstor_packet->status !=3D 0) {
> +		dev_err(&device->device, "Obsolete Hyper-V version\n");
>  		return -EINVAL;
> +	}
>=20
>=20
>  	memset(vstor_packet, 0, sizeof(struct vstor_packet));
> @@ -986,11 +928,10 @@ static int storvsc_channel_init(struct hv_device *d=
evice, bool
> is_fc)
>  	cpumask_set_cpu(device->channel->target_cpu,
>  			&stor_device->alloced_cpus);
>=20
> -	if (vmstor_proto_version >=3D VMSTOR_PROTO_VERSION_WIN8) {
> -		if (vstor_packet->storage_channel_properties.flags &
> -		    STORAGE_CHANNEL_SUPPORTS_MULTI_CHANNEL)
> -			process_sub_channels =3D true;
> -	}
> +	if (vstor_packet->storage_channel_properties.flags &
> +	    STORAGE_CHANNEL_SUPPORTS_MULTI_CHANNEL)
> +		process_sub_channels =3D true;
> +
>  	stor_device->max_transfer_bytes =3D
>  		vstor_packet->storage_channel_properties.max_transfer_bytes;
>=20
> @@ -1289,8 +1230,8 @@ static void storvsc_on_channel_callback(void *conte=
xt)
>  		struct storvsc_cmd_request *request =3D NULL;
>  		u32 pktlen =3D hv_pkt_datalen(desc);
>  		u64 rqst_id =3D desc->trans_id;
> -		u32 minlen =3D rqst_id ? sizeof(struct vstor_packet) -
> -			stor_device->vmscsi_size_delta : sizeof(enum
> vstor_packet_operation);
> +		u32 minlen =3D rqst_id ? sizeof(struct vstor_packet) :
> +			sizeof(enum vstor_packet_operation);
>=20
>  		if (pktlen < minlen) {
>  			dev_err(&device->device,
> @@ -1346,7 +1287,7 @@ static void storvsc_on_channel_callback(void *conte=
xt)
>  		}
>=20
>  		memcpy(&request->vstor_packet, packet,
> -		       (sizeof(struct vstor_packet) - stor_device->vmscsi_size_delta))=
;
> +		       sizeof(struct vstor_packet));
>  		complete(&request->wait_event);
>  	}
>  }
> @@ -1557,8 +1498,7 @@ static int storvsc_do_io(struct hv_device *device,
>  found_channel:
>  	vstor_packet->flags |=3D REQUEST_COMPLETION_FLAG;
>=20
> -	vstor_packet->vm_srb.length =3D (sizeof(struct vmscsi_request) -
> -					stor_device->vmscsi_size_delta);
> +	vstor_packet->vm_srb.length =3D sizeof(struct vmscsi_request);
>=20
>=20
>  	vstor_packet->vm_srb.sense_info_length =3D sense_buffer_size;
> @@ -1574,13 +1514,11 @@ static int storvsc_do_io(struct hv_device *device=
,
>  		ret =3D vmbus_sendpacket_mpb_desc(outgoing_channel,
>  				request->payload, request->payload_sz,
>  				vstor_packet,
> -				(sizeof(struct vstor_packet) -
> -				stor_device->vmscsi_size_delta),
> +				sizeof(struct vstor_packet),
>  				(unsigned long)request);
>  	} else {
>  		ret =3D vmbus_sendpacket(outgoing_channel, vstor_packet,
> -			       (sizeof(struct vstor_packet) -
> -				stor_device->vmscsi_size_delta),
> +			       sizeof(struct vstor_packet),
>  			       (unsigned long)request,
>  			       VM_PKT_DATA_INBAND,
>  			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> @@ -1684,8 +1622,7 @@ static int storvsc_host_reset_handler(struct scsi_c=
mnd
> *scmnd)
>  	vstor_packet->vm_srb.path_id =3D stor_device->path_id;
>=20
>  	ret =3D vmbus_sendpacket(device->channel, vstor_packet,
> -			       (sizeof(struct vstor_packet) -
> -				stor_device->vmscsi_size_delta),
> +			       sizeof(struct vstor_packet),
>  			       VMBUS_RQST_RESET,
>  			       VM_PKT_DATA_INBAND,
>  			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> @@ -1778,31 +1715,31 @@ static int storvsc_queuecommand(struct Scsi_Host =
*host,
> struct scsi_cmnd *scmnd)
>=20
>  	memset(&cmd_request->vstor_packet, 0, sizeof(struct vstor_packet));
>  	vm_srb =3D &cmd_request->vstor_packet.vm_srb;
> -	vm_srb->win8_extension.time_out_value =3D 60;
> +	vm_srb->time_out_value =3D 60;
>=20
> -	vm_srb->win8_extension.srb_flags |=3D
> +	vm_srb->srb_flags |=3D
>  		SRB_FLAGS_DISABLE_SYNCH_TRANSFER;
>=20
>  	if (scmnd->device->tagged_supported) {
> -		vm_srb->win8_extension.srb_flags |=3D
> +		vm_srb->srb_flags |=3D
>  		(SRB_FLAGS_QUEUE_ACTION_ENABLE |
> SRB_FLAGS_NO_QUEUE_FREEZE);
> -		vm_srb->win8_extension.queue_tag =3D SP_UNTAGGED;
> -		vm_srb->win8_extension.queue_action =3D SRB_SIMPLE_TAG_REQUEST;
> +		vm_srb->queue_tag =3D SP_UNTAGGED;
> +		vm_srb->queue_action =3D SRB_SIMPLE_TAG_REQUEST;
>  	}
>=20
>  	/* Build the SRB */
>  	switch (scmnd->sc_data_direction) {
>  	case DMA_TO_DEVICE:
>  		vm_srb->data_in =3D WRITE_TYPE;
> -		vm_srb->win8_extension.srb_flags |=3D SRB_FLAGS_DATA_OUT;
> +		vm_srb->srb_flags |=3D SRB_FLAGS_DATA_OUT;
>  		break;
>  	case DMA_FROM_DEVICE:
>  		vm_srb->data_in =3D READ_TYPE;
> -		vm_srb->win8_extension.srb_flags |=3D SRB_FLAGS_DATA_IN;
> +		vm_srb->srb_flags |=3D SRB_FLAGS_DATA_IN;
>  		break;
>  	case DMA_NONE:
>  		vm_srb->data_in =3D UNKNOWN_TYPE;
> -		vm_srb->win8_extension.srb_flags |=3D
> SRB_FLAGS_NO_DATA_TRANSFER;
> +		vm_srb->srb_flags |=3D SRB_FLAGS_NO_DATA_TRANSFER;
>  		break;
>  	default:
>  		/*
> @@ -2004,7 +1941,6 @@ static int storvsc_probe(struct hv_device *device,
>  	init_waitqueue_head(&stor_device->waiting_to_drain);
>  	stor_device->device =3D device;
>  	stor_device->host =3D host;
> -	stor_device->vmscsi_size_delta =3D sizeof(struct vmscsi_win8_extension)=
;
>  	spin_lock_init(&stor_device->lock);
>  	hv_set_drvdata(device, stor_device);
>  	dma_set_min_align_mask(&device->device, HV_HYP_PAGE_SIZE - 1);
> @@ -2217,10 +2153,6 @@ static int __init storvsc_drv_init(void)
>  	 * than the ring buffer size since that page is reserved for
>  	 * the ring buffer indices) by the max request size (which is
>  	 * vmbus_channel_packet_multipage_buffer + struct vstor_packet + u64)
> -	 *
> -	 * The computation underestimates max_outstanding_req_per_channel
> -	 * for Win7 and older hosts because it does not take into account
> -	 * the vmscsi_size_delta correction to the max request size.
>  	 */
>  	max_outstanding_req_per_channel =3D
>  		((storvsc_ringbuffer_size - PAGE_SIZE) /
> --
> 2.25.1

