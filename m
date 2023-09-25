Return-Path: <linux-hyperv+bounces-267-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598EC7ACCFF
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Sep 2023 02:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 763CF1C20434
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Sep 2023 00:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DA3101DB;
	Mon, 25 Sep 2023 00:00:35 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B51DF52
	for <linux-hyperv@vger.kernel.org>; Mon, 25 Sep 2023 00:00:33 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A25DF;
	Sun, 24 Sep 2023 17:00:30 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68cc1b70e05so1370761b3a.1;
        Sun, 24 Sep 2023 17:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695600030; x=1696204830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SRArSTXJud9iO+LuiOtWiYL7QKMVDyDtJlWe0NRhArI=;
        b=Ux+GYKEIRxhpvtAB8yPxfzpokmw1YPXF3ghA5EnflkLv9vab91p0Ys9JmUdOhxdMI3
         GTzhAu0UGYAoe4/Q8fEs1+T3+7TvucrRY/m6SOuU4MV2w4kXTx7zD69OS4HOa844dQaI
         /ILeLILZEQ2gzFa7q2uOp2UI+4Okl9tjTWIIyxxfeNDPV/wHmA11gcLT3Qgjwj7evMyf
         0sChrnfi2aoNYjTcrDMRErMmITGsVmuvPI5jMDbx6yzxW34qcK5m7f+opT1788V9/ifV
         lPB3CzYHiOWCo/HELuaJVLLiMMHCpGQtCSRVVTc6F94NA9nJLjTHSQ9ij4Fb7+ClQjDa
         vzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695600030; x=1696204830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRArSTXJud9iO+LuiOtWiYL7QKMVDyDtJlWe0NRhArI=;
        b=B/LBQ/B4L1lrQJlQoQTsV35hvDT4jDDSf9f2Axq3ov5wtUUfhEc5V+i3DKd2W55135
         TmcRFGUlJDnVG/uLj3JGqE9Iet+6SwZSo9YVxAqKFfMUFKv81U+CFddA7srCchbC7ctr
         gpnIqPvKfQJeNyEa0ZuZ+oFbF0/fGPNZaN7GLml45y4YO+D8UhBNjNmfKjrT43uaVZLu
         c/fAtOd3yWzyKsZEFo3G8+xUTo4QYbrqwlTNTq/TvRhiw2psK7gPQXmoYdPjDeiusGcg
         1RShZMMA4lheN0uvhDbd9ddC2rYApCeV7eDg2EM8CjoUXRglgjPpEGl73Wi3QIjWI74K
         aYqg==
X-Gm-Message-State: AOJu0YzPtSR3VA5WdKd/YGbdhOfTd+AoS9Z0Oqg00QU2qJzJ/hRmRENf
	S9wygJXHraneUsKUx/XO4mE=
X-Google-Smtp-Source: AGHT+IFZjXcxo45vH04/tXWEB8aCKMyp6ne0ynOxQ45vG4yDpii988ZdHDNwsDmu48yUh4yj+Ln/+w==
X-Received: by 2002:a05:6a00:999:b0:690:2ab8:2d67 with SMTP id u25-20020a056a00099900b006902ab82d67mr6461931pfg.1.1695600029966;
        Sun, 24 Sep 2023 17:00:29 -0700 (PDT)
Received: from sivslab-System-Product-Name ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id g23-20020aa78197000000b0068be348e35fsm6730219pfi.166.2023.09.24.17.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 17:00:29 -0700 (PDT)
Date: Mon, 25 Sep 2023 08:00:26 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: kys@microsoft.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: hv: kvp: fix memory leak in realloc failure
 handling
Message-ID: <20230925000026.GA1101960@sivslab-System-Product-Name>
References: <20230924055148.1074754-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230924055148.1074754-1-visitorckw@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Sep 24, 2023 at 01:51:48PM +0800, Kuan-Wei Chiu wrote:
> In the previous code, there was a memory leak issue where the
> previously allocated memory was not freed upon a failed realloc
> operation. This patch addresses the problem by releasing the old memory
> before setting the pointer to NULL in case of a realloc failure. This
> ensures that memory is properly managed and avoids potential memory
> leaks.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  tools/hv/hv_kvp_daemon.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> index 27f5e7dfc2f7..af180278d56d 100644
> --- a/tools/hv/hv_kvp_daemon.c
> +++ b/tools/hv/hv_kvp_daemon.c
> @@ -209,11 +209,13 @@ static void kvp_update_mem_state(int pool)
>  			 * We have more data to read.
>  			 */
>  			num_blocks++;
> -			record = realloc(record, alloc_unit * num_blocks);
> +			struct kvp_record *record_tmp =
> +				realloc(record, alloc_unit * num_blocks);
>  
> -			if (record == NULL) {
> +			if (record_tmp == NULL) {
>  				syslog(LOG_ERR, "malloc failed");
>  				kvp_release_lock(pool);
> +				free(record);
>  				exit(EXIT_FAILURE);
>  			}
>  			continue;
> @@ -345,11 +347,15 @@ static int kvp_key_add_or_modify(int pool, const __u8 *key, int key_size,
>  	 */
>  	if (num_records == (ENTRIES_PER_BLOCK * num_blocks)) {
>  		/* Need to allocate a larger array for reg entries. */
> -		record = realloc(record, sizeof(struct kvp_record) *
> -			 ENTRIES_PER_BLOCK * (num_blocks + 1));
> +		struct kvp_record *record_tmp = realloc(
> +			record, sizeof(struct kvp_record) * ENTRIES_PER_BLOCK *
> +					(num_blocks + 1));
>  
> -		if (record == NULL)
> +		if (record_tmp == NULL) {
> +			free(record);
>  			return 1;
> +		}
> +		record = record_tmp;
>  		kvp_file_info[pool].num_blocks++;
>  
>  	}
> -- 
> 2.25.1
>
After tracing the code more thoroughly, I have come to the realization
that the original codebase already handles memory management correctly.
It verifies the success of the realloc operation before updating the
pointer, which means there is no memory leak issue, and there is no
need to release memory explicitly.

Consequently, my proposed changes are unnecessary and could potentially
introduce problems if implemented.

Best regards,
Kuan-Wei Chiu


