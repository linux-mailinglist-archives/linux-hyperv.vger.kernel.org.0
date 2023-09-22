Return-Path: <linux-hyperv+bounces-195-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FA77AB983
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 20:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 97AF428234F
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 18:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79760436AD;
	Fri, 22 Sep 2023 18:45:11 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AAC42BFB
	for <linux-hyperv@vger.kernel.org>; Fri, 22 Sep 2023 18:45:09 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EF6AB;
	Fri, 22 Sep 2023 11:45:09 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1bf5c314a57so21419115ad.1;
        Fri, 22 Sep 2023 11:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695408308; x=1696013108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atbToeCfvaYcx4Wh/Dx61jMrCUFQT/qhHFCE0ode6Mo=;
        b=APSFFRDv4VBfuWYT7rhjPgpigYu8GvZw0OInTiCO62ALGNjCKEqMVtERbEAK1MozTY
         1kTcUaIpoijDwClUgbOytwcJBFY4bYWZLfBe9DKV0MGge25Vvo/N6aqJH+CQyuH4n8pT
         hEdO+NlNsjg6Pn8pSgZUc+SfWyj97qTj4OES4OWychlgclOq9+P8n2R/O3Uezggkjwjr
         0pKi3iHrvqNVglgQ0ByJcoqyALkd9WrI0roh3svEztftPGqu70ZGDaqnfsWJ0Nt+Yw7E
         Ye6yfNO9P/Ob5HT6+4DWT60Q+iZlMovJYM4FpB2jD70NBODEalnNR9HN9dLOu0to0RcG
         SGUw==
X-Gm-Message-State: AOJu0YxgLh72yGDHAciBezE7gm18VfviYxZaIZ0QZEybfFuSthjWIggT
	ZOAN4UOat0s31SYlHy/amFbxu+CDh9w=
X-Google-Smtp-Source: AGHT+IFkYaOsWjga65j1gAjNxQBP0tx3a13MykhAGrHKOBrBgEgFJTEqJ93NywNywSfCEXn7VNmDLQ==
X-Received: by 2002:a17:903:41c3:b0:1c5:70d3:f193 with SMTP id u3-20020a17090341c300b001c570d3f193mr350824ple.10.1695408308401;
        Fri, 22 Sep 2023 11:45:08 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id iw11-20020a170903044b00b001c582de968dsm3832439plb.72.2023.09.22.11.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 11:45:07 -0700 (PDT)
Date: Fri, 22 Sep 2023 18:44:25 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Dexuan Cui <decui@microsoft.com>
Cc: Olaf Hering <olaf@aepfle.de>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1] hyperv: reduce size of ms_hyperv_info
Message-ID: <ZQ3giXQbmloCSil8@liuwe-devbox-debian-v2>
References: <20230918160141.23465-1-olaf@aepfle.de>
 <SA1PR21MB133593AABC414CB427B84FABBFFAA@SA1PR21MB1335.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB133593AABC414CB427B84FABBFFAA@SA1PR21MB1335.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 06:18:53AM +0000, Dexuan Cui wrote:
> > From: Olaf Hering <olaf@aepfle.de>
> > Sent: Monday, September 18, 2023 9:02 AM
> > [...]
> > Use the hole prior shared_gpa_boundary to store the result of get_vtl.
> > This reduces the size by 8 bytes.
> >  [...]
> > --- a/include/asm-generic/mshyperv.h
> > +++ b/include/asm-generic/mshyperv.h
> > @@ -53,8 +53,8 @@ struct ms_hyperv_info {
> >  			u32 reserved_b2 : 20;
> >  		};
> >  	};
> > -	u64 shared_gpa_boundary;
> >  	u8 vtl;
> > +	u64 shared_gpa_boundary;
> >  };
> >  extern struct ms_hyperv_info ms_hyperv;
> >  extern bool hv_nested;
> 
> How about moving the 'vtl' field to an even earlier place:
> 
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -36,6 +36,9 @@ struct ms_hyperv_info {
>         u32 nested_features;
>         u32 max_vp_index;
>         u32 max_lp_index;
> +
> +       u8 vtl;
> +
>         union {
>                 u32 isolation_config_a;
>                 struct {
> @@ -54,7 +57,6 @@ struct ms_hyperv_info {
>                 };
>         };
>         u64 shared_gpa_boundary;
> -       u8 vtl;
>  };
>  extern struct ms_hyperv_info ms_hyperv;
>  extern bool hv_nested;
> 
> This also reduces the size by 8 bytes, and keeps
> the isolation_config_a/ isolation_config_b/ shared_gpa_boundary
> together, which are related.

Either method works for me.

Will there be a v2 of this patch?

Thanks,
Wei.

