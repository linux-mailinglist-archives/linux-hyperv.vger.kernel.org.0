Return-Path: <linux-hyperv+bounces-509-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 507197C4404
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Oct 2023 00:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09430282157
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Oct 2023 22:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBFD354E5;
	Tue, 10 Oct 2023 22:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sOLzgyav"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD59354E8
	for <linux-hyperv@vger.kernel.org>; Tue, 10 Oct 2023 22:27:51 +0000 (UTC)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7DC1A6
	for <linux-hyperv@vger.kernel.org>; Tue, 10 Oct 2023 15:27:42 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-65b0a54d436so34304746d6.3
        for <linux-hyperv@vger.kernel.org>; Tue, 10 Oct 2023 15:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696976861; x=1697581661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkLtTpyq6hhRKA1Cd8NmRte6SMNGKfwrDP5J91+SqxM=;
        b=sOLzgyavxmNPuIxJT66RHVRJKPM4L7Y9mosU4527HC4w8KJRNktEAYHaiOvOQgSk1W
         WgDXRkFGo2xLRGU3Eek+jCG4D0655oAzIpaEmUvKLlz9gC4+1srsdf640xGp/hMxnMJB
         VI6e4mzHz8VGpe7Gibg3n7Nox0eAy4azTsx1/hd74JY/Sh2gbeQnrqmWf0Ug4VMud0gp
         gEZoVEoqLrmoJQLPyNKJcNMdeMj4uAIYxWDoVlT9WrATIxVQb0axKhX8KXqvTlezx/0T
         CxZSH2FaCGcV1lUwERDBgx6SFAqdgeW6kzeRn+UnLXDocf6UZXePvumzIzchPf/o7XlC
         de5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696976861; x=1697581661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkLtTpyq6hhRKA1Cd8NmRte6SMNGKfwrDP5J91+SqxM=;
        b=dTkwDnFNiRuQLuMW3WV2glcXMSBTQX1sO6do93IvymNumNOsSkBVs7T8Hd2xbTxLhT
         aobgjgQZpDWHDcm9sUPwTANwyvCuDm4ItBG8MQyaNL6DeUlFGjtoJo/sIGlqJ4OUpxjn
         OIRZ1xf4D8T5KJ+X7YgDkTo9x3NvQ6iyNq2pGbKdnFaHtJkWqZdPPxiuLtMqI1ufx3N5
         WDKb09+P4hY+JBt2oJ/lyxOe7/K9Yvd/zgmwiv+6jDeJCJ7QEURgolwj9m5QITuaL67N
         uwQg/S/S64YFrK0ypznIQqPfdcuYeoWqV9GPNNwR4dMeeYpk/QUvEjNtC3mSvcQMv+Wi
         gNgA==
X-Gm-Message-State: AOJu0YxmTenDlf4lPKSPsFMg0UF4QJQ+furftkcanVW1OgERUCR8obyE
	S5w1el0QEzaox5nlyvEk4LUI5YRFT54Mv+mHdYZaObidRMllBPJGNf4=
X-Google-Smtp-Source: AGHT+IFxlqxkA6VpJQ6lG3e6PyJG8lq0tpawjVN6OqIO8lL7DWTY3wjUGELV0v4sDHNRAaW6jqwWvjwYUgNF1SZ5uZw=
X-Received: by 2002:a0c:8cca:0:b0:656:3317:b926 with SMTP id
 q10-20020a0c8cca000000b006563317b926mr16022671qvb.17.1696976861005; Tue, 10
 Oct 2023 15:27:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1696965810-8315-1-git-send-email-haiyangz@microsoft.com> <20231010151404.3f7faa87@hermes.local>
In-Reply-To: <20231010151404.3f7faa87@hermes.local>
From: Yuchung Cheng <ycheng@google.com>
Date: Tue, 10 Oct 2023 15:27:05 -0700
Message-ID: <CAK6E8=c576Gt=G9Wdk0gQi=2EiL_=6g1SA=mJ3HhzPCsLRk9tw@mail.gmail.com>
Subject: Re: [PATCH net-next,v2] tcp: Set pingpong threshold via sysctl
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, linux-hyperv@vger.kernel.org, 
	netdev@vger.kernel.org, kys@microsoft.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, 
	dsahern@kernel.org, ncardwell@google.com, kuniyu@amazon.com, 
	morleyd@google.com, mfreemon@cloudflare.com, mubashirq@google.com, 
	linux-doc@vger.kernel.org, weiwan@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 3:14=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Tue, 10 Oct 2023 12:23:30 -0700
> Haiyang Zhang <haiyangz@microsoft.com> wrote:
>
> > TCP pingpong threshold is 1 by default. But some applications, like SQL=
 DB
> > may prefer a higher pingpong threshold to activate delayed acks in quic=
k
> > ack mode for better performance.
> >
> > The pingpong threshold and related code were changed to 3 in the year
> > 2019 in:
> >   commit 4a41f453bedf ("tcp: change pingpong threshold to 3")
> > And reverted to 1 in the year 2022 in:
> >   commit 4d8f24eeedc5 ("Revert "tcp: change pingpong threshold to 3"")
> >
> > There is no single value that fits all applications.
> > Add net.ipv4.tcp_pingpong_thresh sysctl tunable, so it can be tuned for
> > optimal performance based on the application needs.
> >
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
>
> If this an application specific optimization, it should be in a socket op=
tion
> rather than system wide via sysctl.
Initially I had a similar comment but later decided a sysctl could
still be useful if
1) the entire host (e.g. virtual machine) is dedicated to that application
2) that application is difficult to change

