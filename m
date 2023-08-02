Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C8D76D4E5
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Aug 2023 19:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjHBRPT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Aug 2023 13:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjHBRPR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Aug 2023 13:15:17 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021016.outbound.protection.outlook.com [52.101.62.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8493581;
        Wed,  2 Aug 2023 10:14:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUmxV9BXYCEYDkdAr6SHMZ4II0dNf3ieQH5jJEfWU/Yo+i1j2BM+jcwxAS6LCtl5nwYOjvI/T15AXNp4D7hXiUQrFmafP43Nz6x2BedrCzDYHVn4W4Ak5Wbc8rSXaGcjt/lO12NWAFSTtm0KripQVN99oXepoxjNadaQJ1at8CEqzaWAvXhLVKO+m3evxiO7yLIHWvu1FhkodSZLqV2l0KUfx89mNZ89Hsqxp4Qhfmy6l98i8VP1HNdMKjhegxfxDxNF6PivxMD5srZ0sinrSqxHyLY+qgCl3xgiw7IZVSfcu4ZtSEOhueJoaJBRB9p7AzGn9PTMBqBlfKJ8feQJ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnKvyJ18gz16wnYGJ8j7zI1nVCDVm6zDfWA7kj8CBD0=;
 b=mZ38O4ZsvZIMP/CL7y65vwXZODi14l1zLwNaoGaa93vIGq3zw8Anbg8hVZvlV1xhh5Wixpf/wyrm8pKixlK2zEAOA9HPBp9jUdoyNYnnIG3hjvhoeAHrItEe5ZEGlS9QPtgrApbs72KFdcY1uETFPytW5N6getzaGfwq4EPANIDR0gVodGeS173oad5sTeqzyfEdj0FBZSPqOPJnlVZ6+RN31YSh8BTmcNSCYng6BaTkAPk9vOyGOHGf4dEkR2+d3U4BbERZCZRbywUS5HYMmNKxSrsl/KmXvJImPeGr5BHh/jC1vrLvP3UUlEUXRg4iHxYBGuYzk26EeKbcpb6S3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnKvyJ18gz16wnYGJ8j7zI1nVCDVm6zDfWA7kj8CBD0=;
 b=F9XZ2bPxTFfpzx0b7X0hiNucr/xZRSKEJ9c6aiWRIXkXFPG/1ogg0tC79oT2CXvtBzShBdLhwkDq7IAKcFIjWA44YySunE/MtHOD44avv5shDXWCQ2QyBD2YDQCWsv2Z1L8VsvHWL3uaFcPLtmDAbxZz8nl3szpceZBDLufCkcQ=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BL1PR21MB3209.namprd21.prod.outlook.com (2603:10b6:208:396::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.8; Wed, 2 Aug
 2023 17:14:43 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f%3]) with mapi id 15.20.6652.004; Wed, 2 Aug 2023
 17:14:43 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Sonia Sharma <sosha@linux.microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
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
Subject: RE: [PATCH] hv_netvsc: fix netvsc_send_completion to avoid multiple
 message length checks
Thread-Topic: [PATCH] hv_netvsc: fix netvsc_send_completion to avoid multiple
 message length checks
Thread-Index: AQHZxQVQdXJzjtZSzk6I2z3MndS5yK/XPhqw
Date:   Wed, 2 Aug 2023 17:14:43 +0000
Message-ID: <BYAPR21MB168878FE729DB8E57CABBB69D70BA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1690955450-5994-1-git-send-email-sosha@linux.microsoft.com>
In-Reply-To: <1690955450-5994-1-git-send-email-sosha@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=96cc346b-c973-4882-86ac-acfdcb222869;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-02T17:09:18Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BL1PR21MB3209:EE_
x-ms-office365-filtering-correlation-id: 8acbbe37-9d3f-459f-38d2-08db937bf69e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zj7TXXZVsbSpjwQGiqN6/F2pDWz/+RPgfnEuLQfUoLKb5U7uQ+k4JgNVFsODfGKjwT6T9UKryuq8NLsKwHmruvJQ1GC3u4p1uku/ce5QkAdqCqtmhBSWbC81QfZZonnQNj+DHRBSgP7nWi0sMTmiPo9bJIGUNr5UndPYj8eHrDBwmoqKwmRnPA3yYiKxX43IX7PdaxKFfHMJTUfbx8jjkAP7oqsW4OzK2IZvw0Hg2iQN0UiaLTf3GWDSHMrmN9qU7Z5b0mMTGzHztwF8PWIfCjpyeGtededLhEq/bzBkm4VZIX5KMEs7j1K9TxAbHK9rn0B/A5MOdRIFHNbvT5NgMJH9xhuHVKP+VG6n/htbDXKWKctUHFmFh4zzt7ZMBtlEtPOzFGfLyTlQqgEVYmMLbsYhCaFCh2LXaU7nw3aATpZiUFryfJeXmm2zKFsn42vrWGQGq5tV8aO9EYlcMH4jfh128CBE3GFb97YRevFq4QF0OVsQYl0dZrhYol64b72W6rZlqaVxrSH3zNr+ee9L6W6LrjUdktj+siQ2pW47u146rIbt4aVeDmwh8EM6qyN9P2LOzf26ugFoqw4GYGnWNQd0qTM3BkB5Xf/v5HSWFsPG/TtLJFoXIU9QeT6uIbx9mMZSXFs3dubBUjonfryMEMzXr5944BjjciBAxKPC+bY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199021)(33656002)(10290500003)(8990500004)(110136005)(9686003)(2906002)(38070700005)(478600001)(7696005)(83380400001)(54906003)(82960400001)(86362001)(82950400001)(122000001)(71200400001)(76116006)(52536014)(786003)(316002)(4326008)(64756008)(66556008)(66946007)(66446008)(66476007)(8936002)(8676002)(186003)(38100700002)(26005)(55016003)(5660300002)(41300700001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/Rwo5v/M8Q51YF89jmftbU8dLOwcVuih2FxQh8PrmS6LrrqFoXzQ3NXZrOvm?=
 =?us-ascii?Q?xnFz/2rLuqdUYB4Z8OZrjqa1SxiR+Nx+bfuRynFTQHRU2cbX1ZKYjCDohVKr?=
 =?us-ascii?Q?s6vgm/QmdaiF+7RCNmVO/IzCxeRwyKw136E06TN86YslsGhBb/V59aFhzYuQ?=
 =?us-ascii?Q?c2TsgEv5R/imeL+ZD2A9/56YMVA6LOe/1GqYlqlQqj7ZxW33l0Z1L8JoRtDN?=
 =?us-ascii?Q?iqk7JLltYSPyxrbntgFTRTNukAWo8596FVrB9mzATl/O3j/aa9sunQ8731zw?=
 =?us-ascii?Q?MLHkOeNxiQGwF+ox8+T+BpRZFpx6ALsHgwOoeEX6n0R0grb5N7BAU/OVLcln?=
 =?us-ascii?Q?YtnhxpNdrRw05xwcJX2F+IZ/Qdw3L0RKTLA6Q05Kk6CKQHF6tuNK8TpR6RAN?=
 =?us-ascii?Q?2xG6CnJkO9cpr1d9OCHCt1+RSiPSYqvowGGxPBVI0xDNWy4IAx2InDTRDiu3?=
 =?us-ascii?Q?3JQZaYtiSWJWkddKY/1xF5KL2diZ7Ovkqelfdq29Aj+7o9DRVa6ugbOSK4O2?=
 =?us-ascii?Q?Gg3ygLuB+fIR7BTgSzrow1beEdlyUEcSe3mSTQ6Eb1EkCOclwk/ZM8c6Y2GX?=
 =?us-ascii?Q?8nREnVL38T+cvwf+tO+MoGxmugCoUmjnysY5GLhZA5G7oGT2brtsOLExVP8i?=
 =?us-ascii?Q?RV/IyLb5Cm+uq/GoZ6xVzMOw95m5Je4/i8IjiAl0ZD02L7ohhn6zvhg+2W4d?=
 =?us-ascii?Q?dycQ2glXVYm3gB4Jlzxkj7ADK3P9KU0K7Oe3SN1o0gdanjEfACpTU+utifSU?=
 =?us-ascii?Q?BBLMD37Hk4VgmyK3qY5CDAqI1k8cy4S3R3cmnQnOqewXqYQpp0IXwXV0G7n7?=
 =?us-ascii?Q?pND4wY8MbwLbGLToEsHyxnkUdVETRzdQ5DpOCCKrcH17ZkWhIw7QMoPfYn1r?=
 =?us-ascii?Q?i5czDDJNBOcY3X9AJzOmwyy3l4s+goeVhR8FYmqQSeGaXRuwuoYiqWsw9ZHs?=
 =?us-ascii?Q?Fjp9u7UiZ0Q4veQljgkYqTHKiz4M0sNCg0LsiPCY8kWHJIGeuRVSIxBKdwfL?=
 =?us-ascii?Q?RiE4pMcTDjTrcgqmXlNxmDfU1jK/6q0eJ2coIQv9BDAFi9oK3KCojFeAPQY3?=
 =?us-ascii?Q?xuuHDzYLVLbSXQUO16QeTB3hEFzG4uGaF/U0290d2H41sFHHaLfs1XVd/FEQ?=
 =?us-ascii?Q?28sg7NgqclbTAu4cQv2kJUu0mSAh+if3HvNG8BPhXCe5cbiBg4rxH4LBcGO2?=
 =?us-ascii?Q?zgO3KzCj/b9uOjbMPl2uKuHUqBPUJfaZJwJxPTgx3hU3mMlsn9sOYlGpnWAP?=
 =?us-ascii?Q?+Dw78m1nce2hw/LUQlEYSddWO7Q1iF/3uMwBNcIwNTui5xGcl3Yn7eB/bsRZ?=
 =?us-ascii?Q?jYMidGaPeK1WKShILWGb/iyi61wAuBSmbHXXxvh7D5hJaeinA+KvQCKRoH9K?=
 =?us-ascii?Q?0lByM8fbiE+shvPCR50ed88TW0Y0e7sg2k95UalpjXPhqvqPpqpvWoVGBqmu?=
 =?us-ascii?Q?QB5ONJHJc/ia+omoMOet13HNLD1piDop8Zv0659y25sy2ve3AC2S8IUZpTjy?=
 =?us-ascii?Q?jMOjB19MEHgiBtaYaUJYZ3Fbk5CksPuFqn6LcO0Vb5ZOLBPsWwUmRbtrozGf?=
 =?us-ascii?Q?MYFC/5FpgasRaTZkR1d9iDJps77nE0mqiVn6WyYq/z5cXKl9XfUnS65LcGgO?=
 =?us-ascii?Q?Hw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acbbe37-9d3f-459f-38d2-08db937bf69e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 17:14:43.0495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mybnfMIgQcD54Z/fRYoGnqp46NMuUhzHqC0sW4RcH+P0Bz6sZxTqxMLS24e8wlmBvaNH1POVffDraqSf6xv02DOwilpRDGWx8bMQvb9CWcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3209
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Sonia Sharma <sosha@linux.microsoft.com> Sent: Tuesday, August 1, 202=
3 10:51 PM
>=20

The Subject line for networking patches should be tagged
with "net" for fixes to the release that's currently in progress,
or "net-next" for the next release.  Bug fixes like this one can
be "net".   Look through the mailing list archives for examples.

> switch statement in netvsc_send_completion() is incorrectly validating

s/switch/The switch/

> the length of incoming network packets by falling through next case.

s/through next case/through to the next case/

> Avoid the fallthrough, instead break after a case match and then process

s/fallthrough, instead/fallthrough.  Instead,/

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

Need to add a "return" statement here so that the error case doesn't
try to do the memcpy() and complete().

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

