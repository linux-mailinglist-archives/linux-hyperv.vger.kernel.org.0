Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FDC76DC6F
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Aug 2023 02:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjHCAOt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Aug 2023 20:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHCAOs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Aug 2023 20:14:48 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021023.outbound.protection.outlook.com [52.101.62.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5D72D43;
        Wed,  2 Aug 2023 17:14:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxgElVajQh87TgdOBfXTDsSj5GEQVa8CRLSaxtaOKUqidVni5V+jh1K5PTya+Quy8DYczcwY61nlqkXmjrSncnrFCXWf2m/jvbKBK9rMuDUu+MznipD5yAbP1f5lW+joYP3pq/nPmqrqPbDNoC3yX+UDlzuEe6X09N+OCrRIHpkuRFsszbGQd8shRC8mqZxMSrvpOFbfkXPCqJUZAafic9dwTDhmRlkq6TemOQ5LKJ2SDFJpUr+FqlmnNU00YZkvJKf0OTGolVQFW8CskgD2BQqrUD++KWRxqtOxV3DFVx52hZb1PxHLnFLoTm25eQGbix+RMKhl6eqsR9wpR5fcvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9AljQHPVefpvMtQkYxv83dypmezBlk06gCFmdb+q1o=;
 b=ar2RZbR/qO5TsCHpRsZ1xur9E+xL6YjFJcayp7eysMkPEjbNYAarBYULAUUdCGa63zGRnWiFidcoGDIsaFUTAdXsT+5ZHc4dfymd8qCxnIA5A61NPGcwhlFHsBszrygt9uJTklY/LzKVJiLGFpM0uYjrMCZcxWWfGEQDiqVTiz3CBvZVRHDpA05FEkleg1btHGeAUrCBdxfBi4LmlQ1daSuHMg419BN3iw3PWhPxAV3keUAxtJ+ooqDQdityAK1D9ju47xzN9ykh/s8jVrWK+9gs5FlC0yOj++nfZuRNweOoYseTfH6TWOqxoD8109eNuU0E0wthKsDpqKHx94c+ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9AljQHPVefpvMtQkYxv83dypmezBlk06gCFmdb+q1o=;
 b=JfamQLsyu2JfhlwBnUAyFKPiXkDNyELtDxoCcQygCNRKCk9jqgI8TKCZ87WJEFVKjlpx8rGqJHXHq1QyP7JuciXqPmR/+Bv0eODsKpvYgUJuYubuaterJwb0tdkBJOfiTx20JfbsT2MayHYbfpqC8qO75daKcaF16EsWeZLhI2Q=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH7PR21MB3165.namprd21.prod.outlook.com (2603:10b6:510:1d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.9; Thu, 3 Aug
 2023 00:14:43 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f%3]) with mapi id 15.20.6652.004; Thu, 3 Aug 2023
 00:14:43 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Sonia Sharma <sosha@linux.microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Sonia Sharma <Sonia.Sharma@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH v2 net] net: hv_netvsc: fix netvsc_send_completion to
 avoid multiple message length checks
Thread-Topic: [PATCH v2 net] net: hv_netvsc: fix netvsc_send_completion to
 avoid multiple message length checks
Thread-Index: AQHZxYuwRa1OoRcAHUiQlhLDftI0Wa/Xs3Yg
Date:   Thu, 3 Aug 2023 00:14:43 +0000
Message-ID: <BYAPR21MB16886B929DDAAD4970FFDAF0D708A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1691013161-14054-1-git-send-email-sosha@linux.microsoft.com>
In-Reply-To: <1691013161-14054-1-git-send-email-sosha@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fde046f2-2fbf-49eb-8797-d17fb3cafb25;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-03T00:13:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH7PR21MB3165:EE_
x-ms-office365-filtering-correlation-id: f36617da-507e-468f-c081-08db93b6a315
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8zPde9wAI3/lQhMk8fQmRkP36kaOP9j4qzkm6g72CI2AOK4eCv6v/GzOhtgYaX3nLjWqKn4OvwNkjlwMSvLI/uNB27Q6aVB8pOqt/avYgn+c6/DtD2h0jcMrLZPkTfJxXWhvN6G9VoGq84GsIRFbjCGyLl4W85e2Ebq26z0ftnq69Nv6y/jAgL1Qy2wHRG7o40+HOsnkx9d5g6gnbDAamvu7Rhdawjjt7duNsE/GSHllN8xebADLvfbEUu4KrNg44tcs3Ms4PywpDoPlqbahkB9Df1xYE6RO9TnFtou/PanY/euO5q3FaxIdhO/R2ZqwYmbAdQq9DKGjLtAqsfFquey+SUwjqeCgCTF2eNKZ1BG2Svd0coIm63F8+fQb9QcRNV39BPSLL8tBKepUnMsbH4LyLopTTVZmRYPnf1poHbB/+S0paE97ttSgMsgQFKsxiUINoq+YMcve1HvXfeDzKfj727yjDtw5UeP2ykMELN5cn0Oes+fiPdWtKox/ddXxNKDAh0mJINP9VLsCMp2jByRJwkkpsTWASurTe8rjCcmijJEoyM8HdAyjyt7haDzVrk1cd+dKv0v/qlwVpc/A2JZxl2Yq3v48+1eql7cvTE8Bnd0QKpAxZAmrTg+c6IrGJCQ8OO8eMSEP2MMqtGyAqmVGyOIJxfLzMdB1qPNlqFQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199021)(33656002)(478600001)(10290500003)(110136005)(9686003)(7696005)(54906003)(26005)(186003)(6506007)(71200400001)(8990500004)(2906002)(4326008)(786003)(316002)(41300700001)(76116006)(66556008)(66946007)(66476007)(64756008)(66446008)(8936002)(8676002)(5660300002)(52536014)(38100700002)(82950400001)(122000001)(82960400001)(38070700005)(86362001)(83380400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HgQjgia5YdqMSESmh4xHRt4dWfm7/rebfoO8VCYL0oMXnd/BwgKaVKxWUi+t?=
 =?us-ascii?Q?RKpsEso16CxW7FBJenua10msMaxxKslQDS3AisyAGazHZV3aVbyHPQw0akIz?=
 =?us-ascii?Q?Ii1dH8FVpIeNdkAeswpLUUb54xhHNXpVUXPPIy/5f7/zmX6BmHN4kT/RDla0?=
 =?us-ascii?Q?/mN9lqWk8saCPAD7MvVVk7JNL+AOw8kAcOGrq4pNX2tExZ90FGp7pSyP/GCL?=
 =?us-ascii?Q?687+sz69+TBVyltOgaDbgzUOQKesNxzPsJpHhUmEMNw+7NKP7PcsW+MEaplw?=
 =?us-ascii?Q?2C8y5SKorIQTVEJbexIcjhrlZ+fkVgF1d132DwdSEHczhlnJq7s+IaY1XQ6J?=
 =?us-ascii?Q?TYcOJzlnT1jzLYwEATYhgqUwA5CqZaP1p/+3pdqpakIAftRh3ePvfrxZKMi/?=
 =?us-ascii?Q?yKwDKTt5Qi0U5LPsdrYRBBpJXSdbIdkvdkou1U+LpItvR1aXGwJLR/xt901d?=
 =?us-ascii?Q?4uIYK7FzJlnVBtu7WzWp/UP9ilMtRSjYZZpDWANXWQruTlFxGxo76OeUfGg8?=
 =?us-ascii?Q?SErApq6kr9ObgV/9uOMySvljjiNnbC8mhCIhZGau9QSM+pErmcQ6KyHpFFV5?=
 =?us-ascii?Q?WLZ/NP1m/KY/P+r559A8sH5boQn4ZbVgM4BXCVCi9P3KPdjjiLYzJO2vJUiI?=
 =?us-ascii?Q?PYyCNvr5sPu6ldPsKsaV0En5Le9kAxp7669jWAqCHN8zEMml0ahWvdPpIDrL?=
 =?us-ascii?Q?uYz0ytvCuAFPSekBA2fs/Bj9KbNDBkjKcMmt+Yi3yf5KnqKqEjTSiSxA/356?=
 =?us-ascii?Q?tYdBFHxF9318o9TOo49IHNs7HLJ7yW1UagMLQfgh/65nrWoB46xLaCVAg0ve?=
 =?us-ascii?Q?xe4iOTP0tTDZOjnQpD3wxs3Rz0EyyQIVrTQgge6NpESIDQ23ZFHUfcEX0F/M?=
 =?us-ascii?Q?jy1n/IRcefvI6cTQXdTA7fkcHbVehBonwywsud3cQi3NhIzl9Yz59e+gZlgN?=
 =?us-ascii?Q?+Xw3y8jwR+KdWhff6fV2mgh2Wuggzzg4H+v1C2mq0j0Y++8kRgTlmZncWkTh?=
 =?us-ascii?Q?tRkqkLDqzK0l3eMmurzDRnqeAVDkH5yppEvGNVMJrDYdlj5hq4zoLE8u9eWB?=
 =?us-ascii?Q?67fuOxbw2FuldkverLEKRW97PS3iCB0/cYn9L+nZ5g7UfsONeeoHRNxxICRP?=
 =?us-ascii?Q?9f21fBCLLukqryJSt9vatUysayKg21gUOHEE/wxNbnmR5E6pN2NGspSRb8bJ?=
 =?us-ascii?Q?uut9iZPEU5sV2QNNNZEc/pV5iN+7ratEaHT1LLk2lWxurhAuj7JlF3klAtNv?=
 =?us-ascii?Q?HECHHZ7PytiIQcSeQoDcmklWuOwPc/LUJlrmaWX6QsXWko7z4ho6IFICBW8k?=
 =?us-ascii?Q?/p3/E6sm7Torl1HcZvOrn09C3XYCE7ATVdReksH/LcZCGTxOXSTSXUrFh6YM?=
 =?us-ascii?Q?yKXUhB/BFdilSben/v3tSTO47VXYpJejvwNhtTK7sK+Ta5KuK/+I1yojXZOw?=
 =?us-ascii?Q?0Qo5bYWFo1OGOJm6biKNT3ln/Ke22ktkiraCKu+nfZLqPQCAq9YFstaqiI7K?=
 =?us-ascii?Q?bZtUjW/105yHnhZ31HTe1odVyIfBYuIvOUlmPpH0DKfPouivwjPUTERmu6RI?=
 =?us-ascii?Q?sL027qgU386uXTekfNns1eefj6Lx1F3w6dsY2al9mr9ePW2SkqgLi8ZuuH6/?=
 =?us-ascii?Q?sw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f36617da-507e-468f-c081-08db93b6a315
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 00:14:43.2434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GGKZutifPysjDRmPEtWevMlTI9ny3zDX5SQ1upVk3Yrf1zFP87ocBGWpMTBzlMs5xyLIjAIxUU+kWumojKybIv3hO3prCXQdRHSJOpDmnDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3165
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Sonia Sharma <sosha@linux.microsoft.com> Sent: Wednesday, August 2, 2=
023 2:53 PM
>=20
> The switch statement in netvsc_send_completion() is incorrectly validatin=
g
> the length of incoming network packets by falling through to the next cas=
e.
> Avoid the fallthrough. Instead break after a case match and then process
> the complete() call.
>=20
> Signed-off-by: Sonia Sharma <sonia.sharma@linux.microsoft.com>
> ---
>  drivers/net/hyperv/netvsc.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 82e9796c8f5e..347688dd2eb9 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -851,7 +851,7 @@ static void netvsc_send_completion(struct net_device =
*ndev,
>  				   msglen);
>  			return;
>  		}
> -		fallthrough;
> +		break;
>=20
>  	case NVSP_MSG1_TYPE_SEND_RECV_BUF_COMPLETE:
>  		if (msglen < sizeof(struct nvsp_message_header) +
> @@ -860,7 +860,7 @@ static void netvsc_send_completion(struct net_device =
*ndev,
>  				   msglen);
>  			return;
>  		}
> -		fallthrough;
> +		break;
>=20
>  	case NVSP_MSG1_TYPE_SEND_SEND_BUF_COMPLETE:
>  		if (msglen < sizeof(struct nvsp_message_header) +
> @@ -869,7 +869,7 @@ static void netvsc_send_completion(struct net_device =
*ndev,
>  				   msglen);
>  			return;
>  		}
> -		fallthrough;
> +		break;
>=20
>  	case NVSP_MSG5_TYPE_SUBCHANNEL:
>  		if (msglen < sizeof(struct nvsp_message_header) +
> @@ -878,10 +878,6 @@ static void netvsc_send_completion(struct net_device=
 *ndev,
>  				   msglen);
>  			return;
>  		}
> -		/* Copy the response back */
> -		memcpy(&net_device->channel_init_pkt, nvsp_packet,
> -		       sizeof(struct nvsp_message));
> -		complete(&net_device->channel_init_wait);
>  		break;
>=20
>  	case NVSP_MSG1_TYPE_SEND_RNDIS_PKT_COMPLETE:
> @@ -904,13 +900,18 @@ static void netvsc_send_completion(struct net_devic=
e *ndev,
>=20
>  		netvsc_send_tx_complete(ndev, net_device, incoming_channel,
>  					desc, budget);
> -		break;
> +		return;
>=20
>  	default:
>  		netdev_err(ndev,
>  			   "Unknown send completion type %d received!!\n",
>  			   nvsp_packet->hdr.msg_type);

Per my previous comment, still need a "return" statement here
so the default error case does not do the memcpy() and complete().

Michael

>  	}
> +
> +	/* Copy the response back */
> +	memcpy(&net_device->channel_init_pkt, nvsp_packet,
> +			sizeof(struct nvsp_message));
> +	complete(&net_device->channel_init_wait);
>  }
>=20
>  static u32 netvsc_get_next_send_section(struct netvsc_device *net_device=
)
> --
> 2.25.1

