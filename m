Return-Path: <linux-hyperv+bounces-202-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB2F7ABC1F
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 Sep 2023 01:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E2F842823B8
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 23:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6EC48859;
	Fri, 22 Sep 2023 23:01:47 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B012F48854;
	Fri, 22 Sep 2023 23:01:45 +0000 (UTC)
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A98AF;
	Fri, 22 Sep 2023 16:01:43 -0700 (PDT)
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTP
	id jjHCqDsdyez0Cjp9Dq8wGM; Fri, 22 Sep 2023 23:01:19 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id jp9aqUSxwjI4jjp9aqtYmu; Fri, 22 Sep 2023 23:01:43 +0000
X-Authority-Analysis: v=2.4 cv=Uoxwis8B c=1 sm=1 tr=0 ts=650e1cd7
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=i0EeH86SAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=cm27Pg_UAAAA:8 a=YSKGN3ub9cUXa_79IdMA:9 a=QEXdDO2ut3YA:10
 a=y1Q9-5lHfBjTkpIzbSAN:22 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DBDGjSTctz03T3kxqYSvA7eXNQPoYq5wl9a6ycqf3dE=; b=rrlfox9rEpjoN0z0e6OcGu6l3z
	z45KfH2Ubc2bt/MsuiE8FU1H7AlwXb2f157S4keahk67tqZS3qa1f26ffZ8ybjjXKrCaURX9dS4x7
	YoxoheMj0rQJrdBXap8rTF3OZUWJv/P+G1qvqIuddqH4Q8bivOAoQ0d4dIvuN7odfkSWn9us2cEB7
	ELoJwvhGeEwxUWQh+3LlN8+Sg3gSuzmA4B5ss+sWIZ8j3M/15IPv1fgGyc/y4c389vM/CH3710OFZ
	GqBZd5fQzOCeLMSt2qujFy03jFQ9vsYFBRiyq/JdNSOF/Znuw4BfAIPN/v5i5/GyikiGrd8Yc6pCL
	ClLpWPug==;
Received: from [94.239.20.48] (port=51456 helo=[192.168.1.98])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qjkJt-0001Kq-2J;
	Fri, 22 Sep 2023 12:52:02 -0500
Message-ID: <aad8eaeb-2d60-adaa-ee84-7f8b1e7c217c@embeddedor.com>
Date: Fri, 22 Sep 2023 19:52:41 -0600
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 06/14] net: hisilicon: Annotate struct rcb_common_cb with
 __counted_by
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Jamal Hadi Salim <jhs@mojatatu.com>, David Ahern <dsahern@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Claudiu Manoil
 <claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Ajay Sharma <sharmaajay@microsoft.com>, Alex Elder <elder@kernel.org>,
 Pravin B Shelar <pshelar@ovn.org>, Shaokun Zhang
 <zhangshaokun@hisilicon.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
 dev@openvswitch.org, linux-parisc@vger.kernel.org, llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org
References: <20230922172449.work.906-kees@kernel.org>
 <20230922172858.3822653-6-keescook@chromium.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922172858.3822653-6-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.239.20.48
X-Source-L: No
X-Exim-ID: 1qjkJt-0001Kq-2J
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:51456
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKexkz8Jfpu3MlXBpAYmOs70tcVTcPzT4z1Qvmz8Rv4p9VyRm+EFiODf1grqzcSx4WK5ju7qmWbmXdlOuuSMG8pffTi8pmWLx99hiNptpC3hTtZgOcr5
 pvfiEdLjsAkU6xwXiK0S5g0nLd96Cb8tHuYQCixHJWx+Ns4O3VWRaxR3eKrAb02PKgMdvUj9aAsFgoL021r97/q3Cug7XgkwKCHS8Qqj8Z0elcwb6i8Iv3Yg
 W6HRC0QEMy4n2DJfhKD4MWU0BA7Lxyz6zykk++5LzPtYX6feaLZmAnvSqBY0FQ78tvOoHKoM42eET6Nlm1pn2CwrPusfwP1qMLwE2ZclTJdOUpkVp18FMm/9
 yaVyuT+y7+VJgkD9yW0orOEXcYECgssUZufmckjwG5rJ6m+YiORn6x9QLZ4h1epmy0E/MMo8
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/22/23 11:28, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct rcb_common_cb.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Yisen Zhuang <yisen.zhuang@huawei.com>
> Cc: Salil Mehta <salil.mehta@huawei.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h
> index a9f805925699..c1e9b6997853 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h
> @@ -108,7 +108,7 @@ struct rcb_common_cb {
>   	u32 ring_num;
>   	u32 desc_num; /*  desc num per queue*/
>   
> -	struct ring_pair_cb ring_pair_cb[];
> +	struct ring_pair_cb ring_pair_cb[] __counted_by(ring_num);
>   };
>   
>   int hns_rcb_buf_size2type(u32 buf_size);

