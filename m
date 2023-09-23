Return-Path: <linux-hyperv+bounces-205-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E8E7ABDAD
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 Sep 2023 06:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id F3FE1281F6D
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 Sep 2023 04:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11E1802;
	Sat, 23 Sep 2023 04:21:42 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414A67F9;
	Sat, 23 Sep 2023 04:21:40 +0000 (UTC)
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6AD19E;
	Fri, 22 Sep 2023 21:21:39 -0700 (PDT)
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTP
	id jjIJqsSoIEoVsju9CqG1gT; Sat, 23 Sep 2023 04:21:38 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id ju9BqFFs9Vpk9ju9BqNbYN; Sat, 23 Sep 2023 04:21:38 +0000
X-Authority-Analysis: v=2.4 cv=CLw54DnD c=1 sm=1 tr=0 ts=650e67d2
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=cm27Pg_UAAAA:8 a=YSKGN3ub9cUXa_79IdMA:9 a=QEXdDO2ut3YA:10
 a=y1Q9-5lHfBjTkpIzbSAN:22 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LPvTS1JzLrPismrf0ber/g2NvMqPEXpyMEUgBlNSyx4=; b=IxJX69U/JBsYGBW9ZV493LUEH1
	y/qZBCwU71a2dCSFaPOR+ELmo2S7dIQnOQN1I0vArT5N8krNNGsGB6BRp/TOhHlh8K9mLDH+9eyvj
	eYM17ijyOgXB4Bo3yHFbkyTdiz/Ib70vKx8rNQ+Z3SsLa6wAQ+s6Ko9SEgYBrl5ieIKGYBAto9prW
	cKixZSotOqr9gIjhuK98DWEt1yikfE3iIhcLNLiQqZZ3AQZAbgGi4ZEzq5E1FPMTnb4wI4nlk7aQX
	EGtqe9Gmz2LkXaymYyyMRRgBn/oLq5VUa3M0cOFaBUyk0U4gO3mxRKn3tQPkD6a6OKAV1/DQimIr9
	smbUw4Dw==;
Received: from [94.239.20.48] (port=35670 helo=[192.168.1.98])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qjkIL-004OGj-0o;
	Fri, 22 Sep 2023 12:50:25 -0500
Message-ID: <68545f64-067f-4109-8e63-dd00d92cbe09@embeddedor.com>
Date: Fri, 22 Sep 2023 19:51:22 -0600
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 03/14] ipv6: Annotate struct ip6_sf_socklist with
 __counted_by
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
 David Ahern <dsahern@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, Claudiu Manoil
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
 <20230922172858.3822653-3-keescook@chromium.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922172858.3822653-3-keescook@chromium.org>
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
X-Exim-ID: 1qjkIL-004OGj-0o
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:35670
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfL14ygkdy/JX+SlEQ+hwGUSzJFxDi++ZyKHRGzosviPye7A5K6FcGFmObssklXgZFJAjk8T/00MNO1sVvfzC+vp+zJF8dgaI5n/BleNIAaSRlBvXIIeu
 /LgZitsFXwlT+OYj13dySlkMFUSalV85WsmfJvC+KwaLGmfhc3UfsS8uaGwcqXIZHuSXp3JuQq571ymtHC/QS2HL3KfGmWtMe1aKtwJRrUPKH/+cY4W6Io4T
 jktaCOdJixEauX6t/XcrPzpsPLkmIvDgMm55D6Qp9UwQVh70cis7ZbBj4/0UnyeDqFCIiTv0H4lsprk0aKJvsa+LlSURr/NVSOMwm9M9CvgMGFia3z2MvFLZ
 0USv1Sn6dNbjfXjiSvVrTHiyGfsLCLqK25J2ClDwEgSun5U0wcI=
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/22/23 11:28, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ip6_sf_socklist.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
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
>   include/net/if_inet6.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/if_inet6.h b/include/net/if_inet6.h
> index c8490729b4ae..3e454c4d7ba6 100644
> --- a/include/net/if_inet6.h
> +++ b/include/net/if_inet6.h
> @@ -89,7 +89,7 @@ struct ip6_sf_socklist {
>   	unsigned int		sl_max;
>   	unsigned int		sl_count;
>   	struct rcu_head		rcu;
> -	struct in6_addr		sl_addr[];
> +	struct in6_addr		sl_addr[] __counted_by(sl_max);
>   };
>   
>   #define IP6_SFBLOCK	10	/* allocate this many at once */

