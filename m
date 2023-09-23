Return-Path: <linux-hyperv+bounces-265-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B19037AC75B
	for <lists+linux-hyperv@lfdr.de>; Sun, 24 Sep 2023 11:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7037E281589
	for <lists+linux-hyperv@lfdr.de>; Sun, 24 Sep 2023 09:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9019AECB;
	Sun, 24 Sep 2023 09:41:39 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44E67F;
	Sun, 24 Sep 2023 09:41:37 +0000 (UTC)
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31D610C;
	Sun, 24 Sep 2023 02:41:35 -0700 (PDT)
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTP
	id kGalqlK7LOzKlkLcNqLyVb; Sun, 24 Sep 2023 09:41:35 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id kLcMqwMxA8SgTkLcMqZzIU; Sun, 24 Sep 2023 09:41:34 +0000
X-Authority-Analysis: v=2.4 cv=VLTOIvDX c=1 sm=1 tr=0 ts=6510044e
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=BTeA3XvPAAAA:8 a=cm27Pg_UAAAA:8 a=YSKGN3ub9cUXa_79IdMA:9 a=QEXdDO2ut3YA:10
 a=y1Q9-5lHfBjTkpIzbSAN:22 a=AjGcO6oz07-iQ99wixmX:22 a=tafbbOV3vt1XuEhzTjGK:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=odgPbAvrwGH+UmmYpTRJgA4yHGpV4Hdbo+oKj5UQnHY=; b=BF5Tz9di81H3pELwZp3VBCFyHU
	uUNNQ/zbobZcHG93TJTx9zHwXzwtHMZ/SRSoNTJU8sfSUwW1ewC28NOoLbdJuOmQp4jDLT2vXOOr2
	zMVcpCPBnKCPwpMbSIEmongWUMJx0gQix4ECiCdNET6ghNU1ie+mXfOjkCfNKYOPfB22FGwB8PST4
	0pIfU71FcAQ9rz/VOybUQ259V8VbgWGbRNxtBN4Flp6TVbj/F/QN2XydwDU81LG/divmgAEbFwE9T
	12l/w/YWKdP9+RWpoC9EHvBgNHECd9uX39ojSsUh1JbVuZUYC1vdlt55zJLhDPXPKJdRnQPN9BuJt
	1o7mXEqw==;
Received: from [94.239.20.48] (port=41972 helo=[192.168.1.98])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qjkOE-0006cR-1m;
	Fri, 22 Sep 2023 12:56:30 -0500
Message-ID: <ee360342-3f39-73ab-fbc4-22cf3899939a@embeddedor.com>
Date: Fri, 22 Sep 2023 19:57:26 -0600
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 13/14] net: tulip: Annotate struct mediatable with
 __counted_by
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Shaokun Zhang <zhangshaokun@hisilicon.com>, netdev@vger.kernel.org,
 linux-parisc@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
 David Ahern <dsahern@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, Claudiu Manoil
 <claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Ajay Sharma <sharmaajay@microsoft.com>, Alex Elder <elder@kernel.org>,
 Pravin B Shelar <pshelar@ovn.org>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
 dev@openvswitch.org, llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922172449.work.906-kees@kernel.org>
 <20230922172858.3822653-13-keescook@chromium.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922172858.3822653-13-keescook@chromium.org>
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
X-Exim-ID: 1qjkOE-0006cR-1m
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:41972
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfE35Xmr3WOAdQqQHc9iZlMfs2PP5g2rDVR0I4yz7O70Q2O0oRpoVKkroOkzWJoV3+FWgUZNA+u7sXrAGtBviRcDzJ6xYc8gRECzbYaz2Qn9mNFVKNdYg
 hXiAi9PQ+cOpLhSDeaHYa2fZTjwqOcuTB5dM/vvW09ZD2mLVfpcPk8sl2HCktSDPxjWqMCyea33wBgJwnu50wMTP/0qJoyA9vJ3Q0cWTb3JlQ6kdX92LtlsJ
 kbm9b31I9bQghj/8CqQ1EctQpKbVXLlPwkeOgQD7LZma+HWkz3+JSUBMGGHSl4SjKgQkyUCav9ZCta3PnoZhQg2mRenZpuohmrvjP/7SsIVprGAmlrAfyBGl
 1IMWbr4DkYoswcBzDdb5CH+Cw6Ymw4JhcwYghoyKYMfhUGpNjSzDFgSbZ6ESaLzgg+TgVZ3H
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/22/23 11:28, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mediatable.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/net/ethernet/dec/tulip/tulip.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/dec/tulip/tulip.h b/drivers/net/ethernet/dec/tulip/tulip.h
> index 0ed598dc7569..bd786dfbc066 100644
> --- a/drivers/net/ethernet/dec/tulip/tulip.h
> +++ b/drivers/net/ethernet/dec/tulip/tulip.h
> @@ -381,7 +381,7 @@ struct mediatable {
>   	unsigned has_reset:6;
>   	u32 csr15dir;
>   	u32 csr15val;		/* 21143 NWay setting. */
> -	struct medialeaf mleaf[];
> +	struct medialeaf mleaf[] __counted_by(leafcount);
>   };
>   
>   

